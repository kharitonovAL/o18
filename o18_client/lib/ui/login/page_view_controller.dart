import 'package:flutter/material.dart';
import 'package:o18_client/ui/login/sign_in_page/sign_in_page.dart';
import 'package:o18_client/ui/login/sign_up_page.dart';

class PageViewController extends StatefulWidget {
  // PageViewController({required this.loginCallback});
  // final VoidCallback loginCallback;

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
            SignInPage(switchToSignUpPageCallback: switchToSignUpPageCallback),
            SignUpPage(switchToSignInPageCallback: switchToSignInPageCallback),
          ],
        ),
      );

  void switchToSignInPageCallback() {
    if (_controller.hasClients) {
      _controller.animateToPage(
        0,
        duration: Duration(milliseconds: animationDuration),
        curve: Curves.easeInOut,
      );
    }
  }

  void switchToSignUpPageCallback() {
    if (_controller.hasClients) {
      _controller.animateToPage(
        1,
        duration: Duration(milliseconds: animationDuration),
        curve: Curves.easeInOut,
      );
    }
  }
}
