import 'package:flutter/material.dart';

class IsShowDifferenceCheckBox extends StatelessWidget {
  final bool isShowDifference;
  final Function(bool) onIsShowDifferenceStatusChanged;

  const IsShowDifferenceCheckBox({
    required this.isShowDifference,
    required this.onIsShowDifferenceStatusChanged,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      Row(
        children: [
          Checkbox(
            value: isShowDifference,
            onChanged: (value) {
              if (value != null) {
                onIsShowDifferenceStatusChanged(value);
              }
            },
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Text('Показать разницу'),
          ),
        ],
      );
}
