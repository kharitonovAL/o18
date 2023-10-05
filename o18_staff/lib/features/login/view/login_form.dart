import 'package:authentication_repository/authentication_repository.dart';
import 'package:authentication_repository/exception/authentication_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_staff/app/store/app_store.dart';
import 'package:o18_staff/features/login/login.dart';
import 'package:o18_staff/features/login/store/login_store.dart';
import 'package:o18_staff/features/widgets/widgets.dart';
import 'package:o18_staff/theme/theme.dart';
import 'package:o18_staff/utils/utils.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String userRole = StaffRole.staff;
  late final LoginStore loginStore;

  @override
  void initState() {
    loginStore = Provider.of<LoginStore>(
      context,
      listen: false,
    );

    loginStore.setupValidations();

    if (loginStore.currentStaff != null) {
      Provider.of<AppStore>(
        context,
        listen: false,
      ).status = AuthenticationStatus.authenticated;
    }
    super.initState();
  }

  @override
  void dispose() {
    loginStore.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      Container(
        width: 374.w,
        height: 400.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(28.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 42.h),
            Text(
              LoginString.greeting,
              style: AppFonts.heading_2,
            ),
            SizedBox(height: 34.h),
            Padding(
              padding: EdgeInsets.only(
                left: 30.w,
                right: 30.w,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LoginString.email,
                    style: AppFonts.commonText,
                  ),
                  SizedBox(height: 8.h),
                  Observer(
                    builder: (_) => LoginFormTextfield(
                      onChanged: (email) => loginStore.email = email,
                      labelText: LoginString.fillEmail,
                      isValidInput: !loginStore.error.hasErrors,
                    ),
                  ),
                  SizedBox(height: 17.h),
                  Text(
                    LoginString.password,
                    style: AppFonts.commonText,
                  ),
                  SizedBox(height: 8.h),
                  Observer(
                    builder: (_) => LoginFormTextfield(
                      onChanged: (password) => loginStore.password = password,
                      labelText: LoginString.fillPassword,
                      isPasswordField: true,
                      isValidInput: !loginStore.error.hasErrors,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Observer(
                    builder: (_) => loginStore.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SizedBox(
                            height: 52.h,
                            width: 322.w,
                            child: AppElevatedButton(
                              title: LoginString.login,
                              onPressed: () async {
                                loginStore.isLoading = true;
                                loginStore.validateAll();

                                if (!loginStore.canLogin) {
                                  loginStore.isLoading = false;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        LoginString.emptyLoginAndPass,
                                      ),
                                    ),
                                  );
                                } else {
                                  try {
                                    await loginStore.login(
                                      email: loginStore.email,
                                      password: loginStore.password,
                                    );

                                    Provider.of<AppStore>(
                                      context,
                                      listen: false,
                                    ).status = AuthenticationStatus.authenticated;

                                    loginStore.isLoading = false;

                                    // TODO enable later
                                    // if (loginStore.currentStaff != null) {
                                    //   final token = StorageRepository.getString('token');
                                    //   log(token, name: 'device token');
                                    //   loginStore.currentStaff!.deviceToken = token;
                                    //   await loginStore.currentStaff!.update();
                                    // }
                                  } on AuthenticationException catch (e) {
                                    loginStore.isLoading = false;
                                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          AuthenticationExceptionMapper.fromCode(e.code),
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ],
        ),
      );
}
