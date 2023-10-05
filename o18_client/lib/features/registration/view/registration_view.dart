import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegistrationView extends StatefulWidget {
  final VoidCallback switchToLoginPage;

  const RegistrationView({
    required this.switchToLoginPage,
  });

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  @override
  Widget build(
    BuildContext context,
  ) =>
      Container(
        child: TextButton(
          onPressed: widget.switchToLoginPage,
          child: Text('back'),
        ),
      );
}
