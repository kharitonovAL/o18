import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_client/theme/theme.dart';

class AppFonts {
  /// Font size 38, weight bold, black
  static TextStyle heading_0 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 38.sp,
    color: AppColors.black,
  );

  /// Font size 30, weight normal, black
  static TextStyle heading_1 = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 30.sp,
    color: AppColors.black,
  );

  /// Font size 26, weight normal, black
  /// For example, used on `LoginPage` on "Управляющая компания" text
  static TextStyle heading_2 = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 26.sp,
    color: AppColors.black,
  );

  /// Font size 24, weight bold, black
  static TextStyle heading_3 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24.sp,
    color: AppColors.black,
  );

  /// Font size 22, weight normal, black
  /// For request history and photos alerts in RequestEditorPage
  static TextStyle heading_4 = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 22.sp,
    color: AppColors.black,
  );

  /// Font size 18, weight bold, green
  /// For selected menu buttons on web app.
  static TextStyle menuSelected = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18.sp,
    color: AppColors.green_0,
  );

  /// Font size 18, weight normal, black
  /// For unselected menu buttons on web app.
  static TextStyle menuUnselected = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 18.sp,
    color: AppColors.black,
  );

  /// Font size 15, weight normal, black
  /// For common text in app
  static TextStyle commonText = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 15.sp,
    color: AppColors.black,
  );

  /// Font size 16, weight normal, black
  /// For common text in app
  static TextStyle commonTextGrey = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 16.sp,
    color: AppColors.grey_2,
  );

  /// Font size 16, weight normal, black
  /// For common text in app
  static TextStyle commonTextBold = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
    color: AppColors.black,
  );

  /// Font size 16, weight normal, black
  /// For common text in app
  static TextStyle commonTextGreen = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
    color: AppColors.green_0,
  );

  /// Font size 16, weight normal, black
  /// For common text in app
  static TextStyle commonTextGreyBold = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
    color: AppColors.grey_2,
  );

  /// Font size 15, weight bold, black
  /// For title text on textFields
  static TextStyle textFieldTitle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15.sp,
    color: AppColors.black,
  );

  /// Font size 15, weight bold, black
  /// For request number in message list item
  static TextStyle messageNumberBold = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15.sp,
    color: AppColors.black,
  );

  /// Font size 15, weight normal, black
  /// For request number in message list item
  static TextStyle messageNumberNormal = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 15.sp,
    color: AppColors.black,
  );

  /// Font size 18, weight normal, grey
  /// For house currentMonth checkbox in CountersTab
  static TextStyle currentMonth = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 18.sp,
    color: AppColors.grey_2,
  );

  /// Font size 18, weight normal, black
  /// For request editor page label
  static TextStyle textFieldLabel = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 18.sp,
    color: AppColors.black,
  );

  /// Font size 18, weight normal, gray
  /// For search bar placeholder on web
  static TextStyle searchBar = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 18.sp,
    color: AppColors.grey_2,
  );

  /// Font size 15, weight normal, black
  /// For email and password field on web login
  static TextStyle emailPassword = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 15.sp,
    color: AppColors.black,
  );

  /// Font size 15, weight normal, black
  /// For text fields on RequestEditorPage
  static TextStyle textFieldBlack = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 15.sp,
    color: AppColors.black,
  );

  /// Font size 15, weight normal, grey
  /// For text fields on RequestEditorPage
  static TextStyle textFieldGrey = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 15.sp,
    color: AppColors.grey_2,
  );

  /// Font size 15, weight normal, grey
  /// For message text in message list item
  static TextStyle messageText = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 15.sp,
    color: AppColors.grey_2,
  );

  /// Font size 15, weight normal, gray
  /// For drop down widget, gray color
  static TextStyle dropDownGrey = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 15.sp,
    color: AppColors.grey_2,
  );

  /// Font size 15, weight normal, black
  /// For drop down widget, black color
  static TextStyle dropDownBlack = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 15.sp,
    color: AppColors.black,
  );

  /// Font size 16, weight bold, white
  /// For page number selector on web
  static TextStyle buttonText = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16.sp,
    color: AppColors.white,
  );

  /// Font size 17, weight 400, black
  /// For table list item on web
  static TextStyle tableItemBlack = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 17.sp,
    color: AppColors.black,
  );

  /// Font size 17, weight 400, black
  /// For table list item on web
  static TextStyle tableItemBlackBold = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 17.sp,
    color: AppColors.black,
  );

  /// Font size 17, weight 400, black
  /// For table list item on web
  static TextStyle tableItemBlackRed = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 17.sp,
    color: AppColors.red,
  );

  /// Font size 15, weight normal, gray
  /// For table list header row on web
  static TextStyle headerRow = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 15.sp,
    color: AppColors.grey_2,
  );

  /// Font size 20, weight normal, black
  /// For request title on request editor
  static TextStyle requestTitle = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 20.sp,
    color: AppColors.black,
  );

  /// Font size 20, weight normal, black
  /// For house title on house editor
  static TextStyle editorTitle = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 20.sp,
    color: AppColors.black,
  );

  /// Font size 20, weight normal, black
  /// For request title on request editor
  static TextStyle requestNumber = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20.sp,
    color: AppColors.black,
  );

  /// Font size 20, weight normal, black
  /// For house title on house editor
  static TextStyle houseInfo = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 34.sp,
    color: AppColors.black,
  );

  /// Font size 16, weight 500.
  /// For buttons on request detail page
  static TextStyle requestEditorButton = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
    color: AppColors.grey_2,
  );
}
