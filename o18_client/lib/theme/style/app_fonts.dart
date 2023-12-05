import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_client/theme/theme.dart';

class AppFonts {
  /// Font size 38, weight bold, black
  static TextStyle heading_0 = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 38,
    color: AppColors.black,
  );

  /// Font size 30, weight normal, black
  static TextStyle heading_1 = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 30,
    color: AppColors.black,
  );

  /// Font size 26, weight normal, black
  /// For example, used on `LoginPage` on "Управляющая компания" text
  static TextStyle heading_2 = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 26,
    color: AppColors.black,
  );

  /// Font size 24, weight bold, black
  static TextStyle heading_3 = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: AppColors.black,
  );

  /// Font size 22, weight normal, black
  /// For request history and photos alerts in RequestEditorPage
  static TextStyle heading_4 = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 22,
    color: AppColors.black,
  );

  /// Font size 18, weight bold, green
  /// For selected menu buttons on web app.
  static TextStyle menuSelected = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: AppColors.green_0,
  );

  /// Font size 18, weight normal, black
  /// For unselected menu buttons on web app.
  static TextStyle menuUnselected = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 18,
    color: AppColors.black,
  );

  /// Font size 15, weight normal, black
  /// For common text in app
  static TextStyle commonText = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 15,
    color: AppColors.black,
  );

  /// Font size 16, weight normal, black
  /// For common text in app
  static TextStyle commonTextGrey = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: AppColors.grey_2,
  );

  /// Font size 16, weight normal, black
  /// For common text in app
  static TextStyle commonTextBold = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.black,
  );

  /// Font size 16, weight normal, black
  /// For common text in app
  static TextStyle commonTextGreen = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.green_0,
  );

  /// Font size 16, weight normal, black
  /// For common text in app
  static TextStyle commonTextGreyBold = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.grey_2,
  );

  /// Font size 15, weight bold, black
  /// For title text on textFields
  static TextStyle textFieldTitle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: AppColors.black,
  );

  /// Font size 15, weight bold, black
  /// For request number in message list item
  static TextStyle messageNumberBold = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: AppColors.black,
  );

  /// Font size 15, weight normal, black
  /// For request number in message list item
  static TextStyle messageNumberNormal = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 15,
    color: AppColors.black,
  );

  /// Font size 18, weight normal, grey
  /// For house currentMonth checkbox in CountersTab
  static TextStyle currentMonth = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 18,
    color: AppColors.grey_2,
  );

  /// Font size 18, weight normal, black
  /// For request editor page label
  static TextStyle textFieldLabel = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 18,
    color: AppColors.black,
  );

  /// Font size 18, weight normal, gray
  /// For search bar placeholder on web
  static TextStyle searchBar = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 18,
    color: AppColors.grey_2,
  );

  /// Font size 15, weight normal, black
  /// For email and password field on web login
  static TextStyle emailPassword = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 15,
    color: AppColors.black,
  );

  /// Font size 15, weight normal, black
  /// For text fields on RequestEditorPage
  static TextStyle textFieldBlack = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 15,
    color: AppColors.black,
  );

  /// Font size 15, weight normal, grey
  /// For text fields on RequestEditorPage
  static TextStyle textFieldGrey = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 15,
    color: AppColors.grey_2,
  );

  /// Font size 15, weight normal, grey
  /// For message text in message list item
  static TextStyle messageText = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 15,
    color: AppColors.grey_2,
  );

  /// Font size 15, weight normal, gray
  /// For drop down widget, gray color
  static TextStyle dropDownGrey = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 15,
    color: AppColors.grey_2,
  );

  /// Font size 15, weight normal, black
  /// For drop down widget, black color
  static TextStyle dropDownBlack = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 15,
    color: AppColors.black,
  );

  /// Font size 16, weight bold, white
  /// For page number selector on web
  static TextStyle buttonText = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppColors.white,
  );

  /// Font size 17, weight 400, black
  /// For table list item on web
  static TextStyle tableItemBlack = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 17,
    color: AppColors.black,
  );

  /// Font size 17, weight 400, black
  /// For table list item on web
  static TextStyle tableItemBlackBold = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 17,
    color: AppColors.black,
  );

  /// Font size 17, weight 400, black
  /// For table list item on web
  static TextStyle tableItemBlackRed = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 17,
    color: AppColors.red,
  );

  /// Font size 15, weight normal, gray
  /// For table list header row on web
  static TextStyle headerRow = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 15,
    color: AppColors.grey_2,
  );

  /// Font size 20, weight normal, black
  /// For request title on request editor
  static TextStyle requestTitle = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 20,
    color: AppColors.black,
  );

  /// Font size 20, weight normal, black
  /// For house title on house editor
  static TextStyle editorTitle = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 20,
    color: AppColors.black,
  );

  /// Font size 20, weight normal, black
  /// For request title on request editor
  static TextStyle requestNumber = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: AppColors.black,
  );

  /// Font size 20, weight normal, black
  /// For house title on house editor
  static TextStyle houseInfo = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 34,
    color: AppColors.black,
  );

  /// Font size 16, weight 500.
  /// For buttons on request detail page
  static TextStyle requestEditorButton = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.grey_2,
  );
}
