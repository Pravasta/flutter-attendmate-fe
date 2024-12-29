import 'package:flutter_attendmate_app/core/constant/constant.dart';
import 'package:flutter_attendmate_app/core/constant/other/assets.gen.dart';
import 'package:flutter_attendmate_app/core/core.dart';
import 'package:flutter_attendmate_app/features/home/bloc/get_attendance_history/get_attendance_history_bloc.dart';
import 'package:flutter_attendmate_app/features/home/bloc/get_schedule_today/get_schedule_today_bloc.dart';
import 'package:flutter_attendmate_app/features/home/bloc/get_user_by_email/get_user_by_email_bloc.dart';
import 'package:flutter_attendmate_app/features/home/view/widget/header_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widget/home_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context
        .read<GetUserByEmailBloc>()
        .add(GetUserByEmailEvent.getUserByEmail());
    context
        .read<GetScheduleTodayBloc>()
        .add(GetScheduleTodayEvent.getScheduleToday());
    context
        .read<GetAttendanceHistoryBloc>()
        .add(GetAttendanceHistoryEvent.getAttendancesHistory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    child: Image.asset(
                      Assets.images.ellips4.path,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: -10,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      child: Image.asset(
                        Assets.images.ellips2.path,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          const HeaderContent(),
          const HomeContent(),
        ],
      ),
    );
  }
}
