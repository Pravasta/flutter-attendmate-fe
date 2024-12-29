import 'package:flutter/material.dart';
import 'package:flutter_attendmate_app/core/constant/constant.dart';
import 'package:flutter_attendmate_app/core/constant/other/assets.gen.dart';
import 'package:flutter_attendmate_app/data/datasources/auth_datasources/auth_local_datasource.dart';
import 'package:flutter_attendmate_app/features/auth/view/login_page.dart';
import 'package:flutter_attendmate_app/features/home/view/home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(
        const Duration(seconds: 3),
        () => AuthLocalDatasourceImpl().isLogin(),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == true) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        } else {
          return Scaffold(
            body: Stack(
              children: [
                Positioned(
                  child: Image.asset(
                    Assets.images.ellips1.path,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'employee system',
                            style: AppText.text24
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Attendance',
                            style: AppText.bigText
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Attendmate v1.0.0',
                              style: AppText.text12.copyWith(
                                color: AppColors.greyColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
