import 'package:flutter_attendmate_app/core/components/loading/shimmer_effect.dart';
import 'package:flutter_attendmate_app/core/extensions/date_time_ext.dart';
import 'package:flutter_attendmate_app/data/model/response/schedule_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/common.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/constant/other/assets.gen.dart';
import '../../../../core/core.dart';
import '../../../../data/model/response/attendance_response_model.dart';
import '../../bloc/get_attendance_history/get_attendance_history_bloc.dart';
import '../../bloc/get_schedule_today/get_schedule_today_bloc.dart';
import 'history_list_widget.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    Widget content(Schedule data) {
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
            children: [
              Text(
                'Live Attendance',
                style: AppText.text16.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor,
                ),
              ),
              Text(
                DateTime.now().toFormattedTimeAMPM(),
                style: AppText.text30.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: 36,
                  color: AppColors.primaryDarkColor,
                ),
              ),
              Text(
                DateTime.now().toFormattedDayMonthYear(),
                style: AppText.text14.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
              const SizedBox(height: 15),
              const Divider(
                color: AppColors.whiteSecondaryColor,
              ),
              const SizedBox(height: 15),
              Text(
                'Office Hours',
                style: AppText.text14.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
              Text(
                '${data.start} - ${data.end}',
                style: AppText.text22.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: DefaultButton(
                      title: 'Clock In',
                      backgroundColor: AppColors.primaryColor,
                      titleColor: AppColors.whiteColor,
                      height: 50,
                      borderRadius: 5,
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.clockIn);
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: DefaultButton(
                      title: 'Clock Out',
                      backgroundColor: AppColors.primaryColor,
                      titleColor: AppColors.whiteColor,
                      height: 50,
                      borderRadius: 5,
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.clockOut);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(
                color: AppColors.whiteSecondaryColor,
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    Assets.icons.userClock.path,
                    scale: 3.5,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Attendance History',
                    style: AppText.text16.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              // LIST ATTENDANCE HISTORY
              BlocBuilder<GetAttendanceHistoryBloc, GetAttendanceHistoryState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => SizedBox(),
                    loading: () {
                      return ShimmerLoading(
                        isLoading: true,
                        child: ListView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return HistoryListWidget();
                          },
                        ),
                      );
                    },
                    error: (error) => Center(
                      child: Text(
                        error,
                        style: AppText.text18,
                      ),
                    ),
                    loaded: (data) {
                      return ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final Attendances history = data[index];

                          return HistoryListWidget(history: history);
                        },
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      );
    }

    return BlocBuilder<GetScheduleTodayBloc, GetScheduleTodayState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            return const SizedBox();
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error) => Center(child: Text(error, style: AppText.text16)),
          loaded: (data) {
            return content(data);
          },
        );
      },
    );
  }
}
