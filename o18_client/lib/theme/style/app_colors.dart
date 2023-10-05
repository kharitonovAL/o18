import 'package:flutter/material.dart';

// Helpful read:
// https://stackoverflow.com/questions/50081213/how-do-i-use-hexadecimal-color-strings-in-flutter

class AppColors {
  /// For background
  static const grey_0 = Color(0xFFE3E3E3);

  /// For searchbar placeholder text and request status icon "Recieved",
  /// also for login dropdown hightlight
  static const grey_1 = Color(0xFFEAEBEC);

  /// For searchbar placeholder text and request status icon "Recieved"
  static const grey_2 = Color(0xFF9899A2);

  /// For email input text field
  static const grey_3 = Color(0xFFF5F6F8);

  /// For email text field placeholder text
  static const grey_4 = Color(0xFFB8B9C2);

  /// For logout button frame
  static const grey_5 = Color(0xFFF1F2F4);

  /// For menu shadow on login page
  static const grey_6 = Color.fromRGBO(186, 180, 190, 0.25);

  /// For email text field placeholder text
  static const grey_7 = Color.fromRGBO(185, 185, 193, 0.25);

  /// For frame in HouseDetailPage
  static const grey_8 = Color.fromRGBO(152, 153, 162, 1);

  /// For disabled elements, such as text
  static const greyDisabled = Color(0xFF9899A2);

  /// For request photos background
  static const greyPhotoBackground = Color(0xFFDFDFDF);

  /// For buttons and other elements
  static const green_0 = Color(0xFF1A965A);

  /// For request status "Done"
  static const green_1 = Color(0xFFD1EADE);

  /// For request status icon "Done"
  static const green_2 = Color(0xFF1A965A);

  /// For request status "Failure"
  static const pink = Color(0xFFF8DEDE);

  /// For request status icon "Canceled"
  static const blueIcon = Color(0xFF3945AE);

  /// For background request status icon "In Progress"
  static const yellow_0 = Color(0xFFF9F5D0);

  /// For request status icon "In Progress"
  static const yellow_1 = Color(0xFFE3CE12);

  static const red = Color(0xFFEB5757);
  static const white = Colors.white;
  static const black = Colors.black;
  static const transparent = Colors.transparent;

  static const shadow = Color.fromRGBO(114, 114, 121, .2);
  static const appBarShadow = Color.fromRGBO(204, 204, 204, .2);
}
