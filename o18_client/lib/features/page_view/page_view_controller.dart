import 'package:flutter/material.dart';
import 'package:o18_client/features/login/view/login_page.dart';
import 'package:o18_client/features/registration/registration.dart';

class PageViewController extends StatefulWidget {
  static Page page() => MaterialPage(child: PageViewController());

  @override
  _PageViewControllerState createState() => _PageViewControllerState();
}

class _PageViewControllerState extends State<PageViewController> {
  final PageController _controller = PageController();

  final int animationDuration = 250;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        body: PageView(
          controller: _controller,
          children: [
            LoginPage(
              switchToRegistrationPage: switchToRegistrationPageCallback,
            ),
            RegistrationView(
              switchToLoginPage: switchToLoginPageCallback,
            ),
          ],
        ),
      );

  void switchToLoginPageCallback() {
    if (_controller.hasClients) {
      _controller.animateToPage(
        0,
        duration: Duration(milliseconds: animationDuration),
        curve: Curves.easeInOut,
      );
    }
  }

  void switchToRegistrationPageCallback() {
    if (_controller.hasClients) {
      _controller.animateToPage(
        1,
        duration: Duration(milliseconds: animationDuration),
        curve: Curves.easeInOut,
      );
    }
  }
}
