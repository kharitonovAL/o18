import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:o18_web/features/login/login.dart';
import 'package:o18_web/features/tab_page/tab_page.dart';

List<Page> onGenerateAppViewPages(
  AuthenticationStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AuthenticationStatus.authenticated:
      return [TabView.page()];
    case AuthenticationStatus.unauthenticated:
      return [LoginPage.page()];

    // ignore: no_default_cases
    default:
      return [LoginPage.page()];
  }
}
