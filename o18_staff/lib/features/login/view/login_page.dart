import 'package:flutter/material.dart';
import 'package:o18_staff/features/login/login.dart';

class LoginPage extends StatelessWidget {
  static Page page() => MaterialPage(child: LoginPage());

  @override
  Widget build(
    BuildContext context,
  ) =>
      SafeArea(
        child: Scaffold(
          body: Center(
            child: LoginForm(),
          ),
        ),
      );
}
