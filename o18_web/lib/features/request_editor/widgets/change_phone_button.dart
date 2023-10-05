import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/widgets/widgets.dart';
import 'package:o18_web/utils/utils.dart';

class ChangePhoneButton extends StatefulWidget {
  final Owner? owner;
  final String buttonTitle;
  final String messageTitle;
  final String labelText;
  final Function(bool) isPhoneChanged;
  final bool enabled;

  const ChangePhoneButton({
    required this.owner,
    required this.buttonTitle,
    required this.messageTitle,
    required this.labelText,
    required this.isPhoneChanged,
    this.enabled = true,
  });

  @override
  State<ChangePhoneButton> createState() => _ChangePhoneButtonState();
}

class _ChangePhoneButtonState extends State<ChangePhoneButton> {
  final _controller = MaskedTextController(
    mask: '+7 (000) 000-00-00',
  );

  @override
  void initState() {
    if (widget.owner != null) {
      _controller.text = widget.owner!.phoneNumber!.toString();
    }
    super.initState();
  }

  @override
  void didUpdateWidget(
    covariant ChangePhoneButton oldWidget,
  ) {
    _controller.text = widget.owner?.phoneNumber == 0
        ? '0000000000'
        : widget.owner!.phoneNumber.toString();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      SizedBox(
        width: 230.w,
        height: 50.h,
        child: OutlinedButton(
          onPressed: widget.enabled
              ? () {
                  if (widget.owner == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(RequestEditorString.ownerNotSet),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26.r),
                        ),
                        title: Text(
                          widget.messageTitle,
                        ),
                        content: AppTextfield(
                          labelText: widget.labelText,
                          title: '',
                          controller: _controller,
                        ),
                        actions: [
                          TextButton(
                            onPressed: Navigator.of(context).pop,
                            child: const Text(
                              RequestEditorString.cancel,
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              widget.owner!.phoneNumber =
                                  int.parse(_controller.text.cleanNumber);
                              final response = await widget.owner!.update();
                              widget.isPhoneChanged(response.success);
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              RequestEditorString.saveChanges,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }
              : null,
          child: Text(
            widget.buttonTitle,
          ),
        ),
      );
}
