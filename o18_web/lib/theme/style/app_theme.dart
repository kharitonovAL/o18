import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_web/theme/theme.dart';

class AppTheme {
  static final light = ThemeData(
    appBarTheme: const AppBarTheme(color: AppColors.white),
    scaffoldBackgroundColor: AppColors.grey_3,
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: AppColors.green_0,
        ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.green_0,
      selectionColor: AppColors.green_0,
      selectionHandleColor: AppColors.green_0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorStyle: const TextStyle(color: AppColors.red),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 20.h,
      ),
      fillColor: AppColors.grey_3,
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(12.r),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.green_0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.grey_2,
        textStyle: AppFonts.searchBar,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    ),
  );

//   static final dark = ThemeData(
//     fontFamily: 'Inter',
//     appBarTheme: AppBarTheme(color: Colors.grey.shade800),
//     scaffoldBackgroundColor: Colors.grey.shade900,
//     colorScheme: ThemeData().colorScheme.copyWith(
//           primary: AppColors.green_0,
//         ),
//     textSelectionTheme: const TextSelectionThemeData(
//       cursorColor: AppColors.green_0,
//       selectionColor: AppColors.green_0,
//       selectionHandleColor: AppColors.green_0,
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       errorStyle: const TextStyle(color: AppColors.red),
//       floatingLabelBehavior: FloatingLabelBehavior.never,
//       contentPadding: EdgeInsets.symmetric(
//         horizontal: 20.w,
//         vertical: 20.h,
//       ),
//       fillColor: Colors.grey.shade900,
//       filled: true,
//       border: OutlineInputBorder(
//         borderSide: BorderSide.none,
//         borderRadius: BorderRadius.all(
//           Radius.circular(12.r),
//         ),
//       ),
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         foregroundColor: AppColors.green_0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//       ),
//     ),
//     outlinedButtonTheme: OutlinedButtonThemeData(
//       style: OutlinedButton.styleFrom(
//         foregroundColor: AppColors.grey_2,
//         textStyle: AppFonts.searchBar,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//       ),
//     ),
//   );
}
