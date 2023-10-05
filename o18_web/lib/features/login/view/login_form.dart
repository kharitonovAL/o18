import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:o18_web/features/login/cubit/login_cubit.dart';
import 'package:o18_web/features/login/login.dart';
import 'package:o18_web/features/widgets/widgets.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String userRole = UserRole.mcOperator;

  @override
  Widget build(
    BuildContext context,
  ) =>
      BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    AuthenticationExceptionMapper.fromCode(
                      state.errorCode ?? -1,
                    ),
                  ),
                ),
              );
          }
        },
        child: Container(
          width: 510.w,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(28.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 56.h),
                  child: Text(
                    LoginString.greeting,
                    style: AppFonts.heading_3,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 40.h,
                    left: 46.w,
                    right: 46.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LoginString.email,
                        style: AppFonts.commonText,
                      ),
                      SizedBox(height: 8.h),
                      _EmailInput(),
                      SizedBox(height: 20.h),
                      Text(
                        LoginString.password,
                        style: AppFonts.commonText,
                      ),
                      SizedBox(height: 8.h),
                      _PasswordInput(),
                      SizedBox(height: 60.h),
                      _LoginButton(
                        userRole: userRole,
                      ),
                      SizedBox(height: 60.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) =>
      BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) => LoginFormTextfield(
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          labelText: LoginString.fillEmail,
          isValidInput: state.email.isValid,
        ),
      );
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) =>
      BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) => LoginFormTextfield(
          onChanged: (password) => context.read<LoginCubit>().passwordChanged(password),
          labelText: LoginString.fillPassword,
          isPasswordField: true,
          isValidInput: state.password.isValid,
        ),
      );
}

class _LoginButton extends StatelessWidget {
  final String userRole;

  const _LoginButton({
    required this.userRole,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      BlocBuilder<LoginCubit, LoginState>(
        // buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) => state.status.isInProgress
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.green_0,
                ),
              )
            : SizedBox(
                height: 58.h,
                width: 417.w,
                child: AppElevatedButton(
                  title: LoginString.login,
                  onPressed: () {
                    if (state.password.isValid && state.email.isValid) {
                      context.read<LoginCubit>().login(userRole: userRole);
                    } else {
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text(
                              LoginString.emptyLoginAndPass,
                            ),
                          ),
                        );
                    }
                  },
                ),
              ),
      );
}
