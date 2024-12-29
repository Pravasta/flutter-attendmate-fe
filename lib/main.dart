import 'package:flutter/material.dart';
import 'package:flutter_attendmate_app/features/attendance/bloc/clock_in/clock_in_bloc.dart';
import 'package:flutter_attendmate_app/features/attendance/bloc/clock_out/clock_out_bloc.dart';
import 'package:flutter_attendmate_app/features/attendance/repository/attendance_repository.dart';
import 'package:flutter_attendmate_app/features/home/bloc/get_attendance_history/get_attendance_history_bloc.dart';
import 'package:flutter_attendmate_app/features/home/bloc/get_schedule_today/get_schedule_today_bloc.dart';
import 'package:flutter_attendmate_app/features/home/bloc/get_user_by_email/get_user_by_email_bloc.dart';
import 'package:flutter_attendmate_app/features/home/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/common/common.dart';
import 'core/constant/style/app_theme.dart';
import 'core/utils/route_observer.dart';
import 'features/auth/bloc/login/login_bloc.dart';
import 'features/auth/bloc/logout/logout_bloc.dart';
import 'features/auth/repository/auth_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc(AuthRepositoryImpl.create())),
        BlocProvider(create: (_) => LogoutBloc(AuthRepositoryImpl.create())),
        BlocProvider(
            create: (_) => GetUserByEmailBloc(HomeRepositoryImpl.create())),
        BlocProvider(
            create: (_) => GetScheduleTodayBloc(HomeRepositoryImpl.create())),
        BlocProvider(
            create: (_) =>
                GetAttendanceHistoryBloc(HomeRepositoryImpl.create())),
        BlocProvider(
            create: (_) => ClockInBloc(AttendanceRepositoryImpl.create())),
        BlocProvider(
            create: (_) => ClockOutBloc(AttendanceRepositoryImpl.create())),
      ],
      child: MaterialApp(
        title: 'Attendmate App',
        theme: AppTheme.darkTheme,
        navigatorKey: navigatorKey,
        initialRoute: RoutesName.initial,
        onGenerateRoute: RoutesHandler.onGenerateRoute,
        debugShowCheckedModeBanner: false,
        navigatorObservers: [routeObserver],
      ),
    );
  }
}
