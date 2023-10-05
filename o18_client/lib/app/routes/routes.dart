import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:o18_client/features/page_view/page_view_controller.dart';
import 'package:o18_client/features/tab_page/view/view.dart';

List<Page> onGenerateAppViewPages(
  AuthenticationStatus status,
  List<Page<dynamic>> pages,
) {
  switch (status) {
    case AuthenticationStatus.authenticated:
      return [TabView.page()];
    case AuthenticationStatus.unauthenticated:
      return [PageViewController.page()];

    // ignore: no_default_cases
    default:
      return [PageViewController.page()];
  }
}
