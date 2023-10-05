import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_web/utils/utils.dart';

class SubmitToWorkButton extends StatefulWidget {
  final VoidCallback onPressed;

  const SubmitToWorkButton({
    required this.onPressed,
  });

  @override
  State<SubmitToWorkButton> createState() => _SubmitToWorkButtonState();
}

class _SubmitToWorkButtonState extends State<SubmitToWorkButton> {
  bool isLoading = false;

  @override
  Widget build(
    BuildContext context,
  ) =>
      SizedBox(
        width: 160.w,
        height: 50.h,
        child: OutlinedButton(
          onPressed: () {
            setState(() {
              isLoading = true;
            });

            widget.onPressed();

            /// if validation failed,
            /// stop CircularProgressIndicator after 3 seconds
            Future.delayed(const Duration(seconds: 3)).then((_) {
              if (mounted) {
                setState(() {
                  isLoading = false;
                });
              }
            });
          },
          child: isLoading
              ? SizedBox(
                  width: 40.w,
                  height: 40.h,
                  child: const CircularProgressIndicator(),
                )
              : const Text(
                  RequestEditorString.toWork,
                ),
        ),
      );
}
