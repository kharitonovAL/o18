import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_web/theme/theme.dart';

class AppFonts {
  /// Font size 38, weight 600, black
  static TextStyle heading_0 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 38.sp,
    color: AppColors.black,
  );

  /// Font size 30, weight 500, black
  static TextStyle heading_1 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 30.sp,
    color: AppColors.black,
  );

  /// Font size 26, weight 500, black
  /// For example, used on `LoginPage` on "Управляющая компания" text
  static TextStyle heading_2 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 26.sp,
    color: AppColors.black,
  );

  /// Font size 30, weight 600, black
  static TextStyle heading_3 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 30.sp,
    color: AppColors.black,
  );

  /// Font size 24, weight 600, black
  /// For request history and photos alerts in RequestEditorPage
  static TextStyle heading_4 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 24.sp,
    color: AppColors.black,
  );

  /// Font size 24, weight 600, black
  /// For house card sections in HouseCardForm
  static TextStyle houseCardSection = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 24.sp,
    color: AppColors.black,
  );

  /// Font size 18, weight 600, green
  /// For selected menu buttons on web app.
  static TextStyle menuSelected = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
    color: AppColors.green_0,
  );

  /// Font size 18, weight 500, black
  /// For unselected menu buttons on web app.
  static TextStyle menuUnselected = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
    color: AppColors.black,
  );

  /// Font size 18, weight 500, black
  /// For common text on web
  static TextStyle commonText = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
    color: AppColors.black,
  );

  /// Font size 18, weight 500, black
  /// For flat_list_item title
  static TextStyle flatItemTitle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
    color: AppColors.black,
  );

  /// Font size 18, weight 500, black
  /// For flat_list_item title
  static TextStyle flatItemTitleGrey = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
    color: AppColors.grey_8,
  );

  /// Font size 18, weight 500, black
  /// For house message title in HouseCardPage
  static TextStyle houseMessageTitle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
    color: AppColors.black,
  );

  /// Font size 18, weight 500, grey
  /// For house message body in HouseCardPage
  static TextStyle houseMessageBody = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
    color: AppColors.grey_2,
  );

  /// Font size 18, weight 500, grey
  /// For house currentMonth checkbox in CountersTab
  static TextStyle currentMonth = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
    color: AppColors.grey_2,
  );

  /// Font size 18, weight 500, black
  /// For request editor page label
  static TextStyle textFieldLabel = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
    color: AppColors.black,
  );

  /// Font size 18, weight 500, gray
  /// For search bar placeholder on web
  static TextStyle searchBar = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
    color: AppColors.grey_2,
  );

  /// Font size 18, weight 500, black
  /// For email and password field on web login
  static TextStyle emailPassword = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
    color: AppColors.black,
  );

  /// Font size 18, weight 500, black
  /// For text fields on RequestEditorPage
  static TextStyle textFieldBlack = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
    color: AppColors.black,
  );

  /// Font size 18, weight 500, grey
  /// For text fields on RequestEditorPage
  static TextStyle textFieldGrey = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
    color: AppColors.grey_2,
  );

  /// Font size 17, weight 500, gray
  /// For flat_list_item subtitle, gray color
  static TextStyle flatItemSubtitle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 17.sp,
    color: AppColors.grey_2,
  );

  /// Font size 17, weight 500, gray
  /// For drop down widget, gray color
  static TextStyle dropDownGrey = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 17.sp,
    color: AppColors.grey_2,
  );

  /// Font size 17, weight 500, black
  /// For drop down widget, black color
  static TextStyle dropDownBlack = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 17.sp,
    color: AppColors.black,
  );

  /// Font size 17, weight 500, black
  /// For house address table item widget, black color
  static TextStyle houseTableitemBlack = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 17.sp,
    color: AppColors.black,
  );

  /// Font size 17, weight 500, black
  /// For counter table item widget, black color
  static TextStyle counterListItemBlack = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 17.sp,
    color: AppColors.black,
  );

  /// Font size 17, weight 500, black
  /// For house table item buttons widget, black color
  static TextStyle houseTableButtonGreen = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 17.sp,
    color: AppColors.green_0,
  );

  /// Font size 17, weight 500, gray
  /// For page number selector on web
  static TextStyle pageNumber = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 17.sp,
    color: AppColors.grey_2,
  );

  /// Font size 18, weight 600, white
  /// For page number selector on web
  static TextStyle buttonText = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
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
  static TextStyle tableItemRed = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 17.sp,
    color: AppColors.red,
  );

  /// Font size 17, weight 400, black
  /// For table list item on web
  static TextStyle tableItemBlackRed = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 17.sp,
    color: AppColors.red,
  );

  /// Font size 14, weight 500, gray
  /// For table list header row on web
  static TextStyle headerRow = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
    color: AppColors.grey_2,
  );

  /// Font size 20, weight 500, black
  /// For request title on request editor
  static TextStyle requestTitle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20.sp,
    color: AppColors.black,
  );

  /// Font size 20, weight 500, black
  /// For house title on house editor
  static TextStyle editorTitle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20.sp,
    color: AppColors.black,
  );

  /// Font size 20, weight 500, black
  /// For request title on request editor
  static TextStyle requestNumber = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 34.sp,
    color: AppColors.black,
  );

  /// Font size 20, weight 500, black
  /// For house title on house editor
  static TextStyle houseInfo = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 34.sp,
    color: AppColors.black,
  );

  /// Font size 17, weight 500.
  /// For request history and request's photos button
  /// on request editor page, black color
  static TextStyle requestEditorButton_0 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 17.sp,
    color: AppColors.black,
  );
}

class FontPath {
  static const openSansReqular = 'fonts/OpenSans-Regular.ttf';
  static const openSansBold = 'fonts/OpenSans-Bold.ttf';
  static const openSansItalic = 'fonts/OpenSans-Italic.ttf';
  static const openSansBoldItalic = 'fonts/OpenSans-BoldItalic.ttf';
}
