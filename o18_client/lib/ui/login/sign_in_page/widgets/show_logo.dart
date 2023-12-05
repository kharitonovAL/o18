import 'package:flutter/material.dart';

class ShowLogo extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) =>
      const Hero(
        tag: 'hero',
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 48,
            backgroundImage: AssetImage('assets/images/appIcon.png'),
          ),
        ),
      );
}
