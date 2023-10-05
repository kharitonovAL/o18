import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/widgets/widgets.dart';
import 'package:o18_web/utils/utils.dart';

class ChangeOwnerButton extends StatefulWidget {
  final Owner? owner;
  final String buttonTitle;
  final String messageTitle;
  final String labelText;
  final Function(bool) isNameChanged;
  final bool enabled;

  const ChangeOwnerButton({
    required this.owner,
    required this.buttonTitle,
    required this.messageTitle,
    required this.labelText,
    required this.isNameChanged,
    this.enabled = true,
  });

  @override
  State<ChangeOwnerButton> createState() => _ChangeOwnerButtonState();
}

class _ChangeOwnerButtonState extends State<ChangeOwnerButton> {
  final _controller = TextEditingController();

  @override
  void initState() {
    if (widget.owner != null) {
      _controller.text = widget.owner!.name!;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(
    covariant ChangeOwnerButton oldWidget,
  ) {
    _controller.text = widget.owner?.name ?? '';
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
                        content: Text(
                          RequestEditorString.ownerNotSet,
                        ),
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
                            child: const Text(RequestEditorString.cancel),
                          ),
                          TextButton(
                            onPressed: () async {
                              widget.owner!.name = _controller.text;
                              final response = await widget.owner!.update();
                              widget.isNameChanged(response.success);
                              Navigator.of(context).pop();
                            },
                            child: const Text(RequestEditorString.saveChanges),
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
