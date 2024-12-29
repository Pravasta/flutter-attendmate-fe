import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_attendmate_app/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/common/common.dart';
import '../../../../core/components/message/message_bar.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/constant/other/assets.gen.dart';
import '../../../../data/datasources/auth_datasources/auth_local_datasource.dart';
import '../../../../data/model/response/login_response_model.dart';
import '../../../auth/bloc/logout/logout_bloc.dart';
import '../../bloc/get_user_by_email/get_user_by_email_bloc.dart';

class HeaderContent extends StatefulWidget {
  const HeaderContent({super.key});

  @override
  State<HeaderContent> createState() => _HeaderContentState();
}

class _HeaderContentState extends State<HeaderContent> {
  @override
  Widget build(BuildContext context) {
    Widget content(User data) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 27,
            child: CachedNetworkImage(
              imageUrl: "${Variable.baseImageUrl}${data.image}",
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  data.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.text16.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${data.employeeId} - ${data.jobTitle}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.text12.copyWith(
                    color: AppColors.whiteSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          BlocConsumer<LogoutBloc, LogoutState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                error: (error) => MessageBar.messageBar(context, error),
                success: (success) async {
                  await AuthLocalDatasourceImpl().removeAuthData();
                  Navigation.pushReplacement(RoutesName.login);
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return IconButton(
                    onPressed: () {
                      context.read<LogoutBloc>().add(LogoutEvent.logout());
                    },
                    icon: Image.asset(
                      Assets.icons.logout.path,
                      scale: 3.5,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            },
          ),
        ],
      );
    }

    Widget contentShimmer() {
      return Shimmer.fromColors(
        baseColor: AppColors.whiteSecondaryColor,
        highlightColor: AppColors.greyColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: AppColors.whiteSecondaryColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 50,
                    color: AppColors.whiteSecondaryColor,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      );
    }

    return BlocBuilder<GetUserByEmailBloc, GetUserByEmailState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            return const SizedBox();
          },
          error: (error) => Text(error, style: AppText.text16),
          loading: () => Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 15, vertical: context.deviceHeight * 0.08),
            child: contentShimmer(),
          ),
          loaded: (data) => Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 15, vertical: context.deviceHeight * 0.08),
            child: content(data),
          ),
        );
      },
    );
  }
}
