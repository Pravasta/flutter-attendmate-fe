import '../../core.dart';
import 'app_colors.dart';
import 'app_text.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData().copyWith(
    scaffoldBackgroundColor: AppColors.primaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      titleTextStyle: AppText.text20.copyWith(fontWeight: FontWeight.bold),
      foregroundColor: AppColors.primaryColor,
      surfaceTintColor: AppColors.primaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(5),
        backgroundColor: AppColors.whiteColor,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: 4,
      backgroundColor: AppColors.greyColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: AppColors.primaryColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.blackColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryColor,
      selectedLabelStyle: AppText.text16.copyWith(fontWeight: FontWeight.bold),
      unselectedItemColor: AppColors.greyColor,
      unselectedLabelStyle: AppText.text16
          .copyWith(color: AppColors.greyColor, fontWeight: FontWeight.bold),
    ),
  );
}
