import 'package:flutter/material.dart';
import 'package:o18_client/features/login/login.dart';

class LoginPage extends StatelessWidget {
  final VoidCallback switchToRegistrationPage;

  const LoginPage({
    required this.switchToRegistrationPage,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      SafeArea(
        child: Scaffold(
          body: Center(
            child: LoginForm(
              switchToRegistrationPage: switchToRegistrationPage,
            ),
          ),
        ),
      );
}
