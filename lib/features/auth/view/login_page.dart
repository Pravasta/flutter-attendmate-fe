import 'package:flutter_attendmate_app/core/components/message/message_bar.dart';
import 'package:flutter_attendmate_app/core/constant/constant.dart';
import 'package:flutter_attendmate_app/core/constant/other/assets.gen.dart';
import 'package:flutter_attendmate_app/core/core.dart';
import 'package:flutter_attendmate_app/data/datasources/auth_datasources/auth_local_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common/common.dart';
import '../bloc/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailC;
  late TextEditingController _passC;
  bool isObsecure = true;

  @override
  void initState() {
    _emailC =
        TextEditingController(text: 'pravasta.fitrayana@attendmate-user.com');
    _passC = TextEditingController(text: 'Cobacoba123#');
    super.initState();
  }

  @override
  void dispose() {
    _emailC.dispose();
    _passC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget contentLogin() {
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15,
              children: [
                Text(
                  'Email',
                  style: AppText.text14.copyWith(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                DefaultField(
                  backgroundColor: AppColors.whiteSecondaryColor,
                  inputType: TextInputType.emailAddress,
                  controller: _emailC,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Input our Email';
                    } else if (!value.contains('@attendmate')) {
                      return 'Email not valid';
                    }
                    return null;
                  },
                ),
                Text(
                  'Password',
                  style: AppText.text14.copyWith(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                StatefulBuilder(
                  builder: (context, setState) {
                    return DefaultField(
                      backgroundColor: AppColors.whiteSecondaryColor,
                      inputType: TextInputType.visiblePassword,
                      isObscure: isObsecure ? true : false,
                      controller: _passC,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObsecure = !isObsecure;
                          });
                        },
                        icon: Icon(
                          isObsecure ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.blackColor,
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Input our Password';
                        } else if (value.length < 8) {
                          return 'Password min 8 characters';
                        }
                        return null;
                      },
                    );
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password',
                    style: AppText.text14.copyWith(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () {},
                      error: (error) => MessageBar.messageBar(context, error),
                      success: (data) async {
                        await AuthLocalDatasourceImpl().saveAuthData(data);
                        Navigation.pushReplacement(RoutesName.home);
                      },
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return DefaultButton(
                          title: 'Login',
                          titleColor: AppColors.whiteColor,
                          backgroundColor: AppColors.primaryColor,
                          height: 50,
                          borderRadius: 5,
                          onTap: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            } else {
                              if (_emailC.text.isNotEmpty &&
                                  _passC.text.isNotEmpty) {
                                context.read<LoginBloc>().add(
                                      LoginEvent.login(
                                        _emailC.text.trim(),
                                        _passC.text.trim(),
                                      ),
                                    );
                              }
                            }
                          },
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
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
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome Back',
                  style: AppText.text30.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Login to your account',
                  style: AppText.text14.copyWith(
                    color: AppColors.whiteSecondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 140),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: AppColors.primaryColor,
              child: Image.asset(
                Assets.images.banner.path,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              color: AppColors.primaryColor,
              child: Image.asset(
                Assets.images.ellips3.path,
                fit: BoxFit.cover,
                color: AppColors.primaryDarkColor,
              ),
            ),
          ),
          contentLogin(),
        ],
      ),
    );
  }
}
