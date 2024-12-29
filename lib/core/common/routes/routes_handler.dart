import 'package:flutter_attendmate_app/features/attendance/view/clock_in_page.dart';

import '../../../features/attendance/view/clock_out_page.dart';
import '../../../features/home/view/home_page.dart';
import '../../../features/intro/view/intro_page.dart';
import '../../../features/auth/view/login_page.dart';
import '../../constant/constant.dart';
import '../../core.dart';
import '../common.dart';

class RoutesHandler {
  final String initialRoutes = RoutesName.initial;
  static const initialNavbarVisibility = true;

  static MaterialPageRoute get _emptyPage {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          body: Center(
            child: Text(
              'Not Found',
              style: AppText.text24.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.initial:
        return MaterialPageRoute(
          builder: (context) => const IntroPage(),
          settings: settings,
        );

      case RoutesName.login:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
          settings: settings,
        );

      case RoutesName.home:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
          settings: settings,
        );

      case RoutesName.clockIn:
        return MaterialPageRoute(
          builder: (context) => const ClockInPage(),
          settings: settings,
        );

      case RoutesName.clockOut:
        return MaterialPageRoute(
          builder: (context) => const ClockOutPage(),
          settings: settings,
        );

      default:
        return _emptyPage;
    }
  }
}
