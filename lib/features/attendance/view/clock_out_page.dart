import 'package:flutter/services.dart';
import 'package:flutter_attendmate_app/core/components/loading/shimmer_effect.dart';
import 'package:flutter_attendmate_app/core/constant/constant.dart';
import 'package:flutter_attendmate_app/core/constant/other/assets.gen.dart';
import 'package:flutter_attendmate_app/core/core.dart';
import 'package:flutter_attendmate_app/core/extensions/date_time_ext.dart';
import 'package:flutter_attendmate_app/features/attendance/bloc/clock_out/clock_out_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../core/common/common.dart';
import '../../../core/components/message/message_bar.dart';
import '../../../data/model/request/attendance_request_model.dart';
import '../../home/bloc/get_attendance_history/get_attendance_history_bloc.dart';

class ClockOutPage extends StatefulWidget {
  const ClockOutPage({super.key});

  @override
  State<ClockOutPage> createState() => _ClockOutPageState();
}

class _ClockOutPageState extends State<ClockOutPage> {
  late TextEditingController _noteController;
  late GoogleMapController mapController;
  double? latitude;
  double? longitude;
  String? myLocation;
  LatLng? selectedLocation;

  Future<void> getCurrentPosition() async {
    try {
      Location location = Location();
      bool serviceEnabled;
      PermissionStatus permissionStatus;
      LocationData locationData;

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      permissionStatus = await location.hasPermission();
      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await location.requestPermission();
        if (permissionStatus == PermissionStatus.granted) {
          return;
        }
      }

      locationData = await location.getLocation();
      latitude = locationData.latitude;
      longitude = locationData.longitude;

      if (latitude != null && longitude != null) {
        await getAddressFromLatLng(latitude!, longitude!);
      }

      setState(() {});
    } on PlatformException catch (e) {
      if (e.code == 'IO_ERROR') {
        debugPrint(
            'A network error occurred trying to lookup the supplied coordinates: ${e.message}');
      } else {
        debugPrint('Failed to lookup coordinates: ${e.message}');
      }
    } catch (e) {
      debugPrint('An unknown error occurred: $e');
    }
  }

  Future<void> getAddressFromLatLng(double lat, double lng) async {
    try {
      List<geo.Placemark> placemarks =
          await geo.placemarkFromCoordinates(lat, lng);

      geo.Placemark place = placemarks[0];
      myLocation =
          "${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}";
    } catch (e) {
      debugPrint('Failed to get address');
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    getCurrentPosition();
    _noteController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LatLng center = LatLng(latitude ?? 0, longitude ?? 0);
    Marker marker = Marker(
      markerId: const MarkerId('marker_1'),
      position: LatLng(latitude ?? 0, longitude ?? 0),
    );

    Widget contentMaps() {
      return Container(
        height: context.deviceHeight * 3 / 5,
        color: AppColors.blackColor,
        child: latitude == null
            ? const Padding(
                padding: EdgeInsets.only(top: 70.0),
                child: Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              )
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: center,
                  zoom: 18,
                ),
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                markers: {marker},
                onMapCreated: _onMapCreated,
              ),
      );
    }

    Widget headerContent() {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 15, vertical: context.deviceHeight * 0.08),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  Assets.icons.back.path,
                  fit: BoxFit.cover,
                  scale: 4,
                ),
              ),
            ),
            Text(
              DateTime.now().toFormattedTimeAMPM(),
              style: AppText.text20.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
              ),
              child: Image.asset(
                Assets.icons.reload.path,
                fit: BoxFit.cover,
                scale: 4,
              ),
            ),
          ],
        ),
      );
    }

    Widget contentClockOut() {
      return Positioned(
        bottom: 0,
        right: 15,
        left: 15,
        child: Container(
          width: context.deviceWidth,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 15,
            children: [
              Text(
                'Clock Out',
                style: AppText.text20.copyWith(
                  color: AppColors.primaryDarkColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColors.greyColor,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Location',
                          style: AppText.text16.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          myLocation ?? '',
                          maxLines: 4,
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.notes_rounded,
                    color: AppColors.greyColor,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Note (optional)',
                          style: AppText.text14.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        DefaultField(
                          inputType: TextInputType.text,
                          controller: _noteController,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              BlocConsumer<ClockOutBloc, ClockOutState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    error: (error) => MessageBar.messageBar(context, error),
                    success: (data) {
                      MessageBar.messageBar(context, 'Success');
                      Navigation.pop();
                      context.read<GetAttendanceHistoryBloc>().add(
                          GetAttendanceHistoryEvent.getAttendancesHistory());
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return DefaultButton(
                        title: 'Clock Out',
                        height: 50,
                        backgroundColor: AppColors.primaryColor,
                        borderRadius: 5,
                        titleColor: AppColors.whiteColor,
                        onTap: () {
                          final data = AttendanceRequestModel(
                            latitude: latitude.toString(),
                            longitude: longitude.toString(),
                            note: _noteController.text,
                          );

                          context
                              .read<ClockOutBloc>()
                              .add(ClockOutEvent.clockOut(data));
                        },
                      );
                    },
                    loading: () {
                      return ShimmerLoading(
                        isLoading: true,
                        child: DefaultButton(
                          title: 'Clock Out',
                          height: 50,
                          backgroundColor: AppColors.primaryColor,
                          borderRadius: 5,
                          titleColor: AppColors.whiteColor,
                          onTap: () {},
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              contentMaps(),
              Container(
                height: context.deviceHeight * 2 / 5,
                color: AppColors.primaryColor,
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              Assets.images.ellips3.path,
              fit: BoxFit.cover,
            ),
          ),
          headerContent(),
          contentClockOut(),
        ],
      ),
    );
  }
}
