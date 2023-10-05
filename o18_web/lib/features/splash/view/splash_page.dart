import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static Page page() => MaterialPage<void>(child: SplashPage());

  @override
  Widget build(
    BuildContext context,
  ) =>
      const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
}
