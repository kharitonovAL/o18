import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_web/theme/theme.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    required this.title,
    required this.textController,
    required this.onChanged,
  });

  final String title;
  final TextEditingController textController;
  final Function(String) onChanged;

  @override
  Widget build(
    BuildContext context,
  ) =>
      SizedBox(
        width: 600.w,
        height: 56.h,
        child: TextField(
          style: AppFonts.searchBar,
          onChanged: onChanged,
          controller: textController,
          decoration: InputDecoration(
            hoverColor: AppColors.white,
            fillColor: AppColors.white,
            label: Text(
              title,
              style: AppFonts.searchBar,
            ),
            prefixIcon: const Icon(
              Icons.search,
            ),
            isDense: true,
            contentPadding: EdgeInsets.all(12.r),
          ),
        ),
      );
}
