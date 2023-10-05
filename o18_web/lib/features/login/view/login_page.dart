import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_web/features/login/cubit/login_cubit.dart';
import 'package:o18_web/features/login/login.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/strings/app_strings.dart';

class LoginPage extends StatelessWidget {
  static Page page() => MaterialPage(child: LoginPage());

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        appBar: AppBar(
          leadingWidth: 500.w,
          toolbarHeight: 90.h,
          leading: Padding(
            padding: EdgeInsets.only(left: 34.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppString.title,
                style: AppFonts.heading_2,
              ),
            ),
          ),
        ),
        body: Container(
          color: AppColors.grey_3,
          child: BlocProvider(
            create: (context) => LoginCubit(
              context.read<AuthenticationRepository>(),
            ),
            child: Center(
              child: LoginForm(),
            ),
          ),
        ),
      );
}
