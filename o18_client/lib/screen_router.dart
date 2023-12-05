import 'package:auth_repository/auth_repository.dart';
import 'package:database_repository/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:o18_client/cubits/auth_cubit/auth_cubit.dart';
import 'package:o18_client/cubits/login_cubit/login_cubit.dart';
import 'package:o18_client/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:o18_client/ui/login/page_view_controller.dart';
import 'package:o18_client/ui/root_page.dart';
import 'package:o18_client/ui/tab_bar_page.dart';

class ScreenRouter {
  static const ROOT = '/';
  static const TAB_BAR_PAGE = 'tab_bar_page';
  static const ENTER = 'enter';

  AuthRepository authRepo = AuthRepository();
  MessagesRepository messageRepo = MessagesRepository();
  AccountRepository accountRepo = AccountRepository();
  CounterRepository counterRepo = CounterRepository();
  FlatRepository flatRepo = FlatRepository();
  HouseRepository houseRepo = HouseRepository();
  ImageRepository imageFileRepo = ImageRepository();
  OwnerRepository ownerRepo = OwnerRepository();
  RequestNumberRepository requestNumberRepo = RequestNumberRepository();

  ScreenRouter() {
    authRepo = AuthRepository();
    messageRepo = MessagesRepository();
    accountRepo = AccountRepository();
    counterRepo = CounterRepository();
    flatRepo = FlatRepository();
    houseRepo = HouseRepository();
    imageFileRepo = ImageRepository();
    ownerRepo = OwnerRepository();
    requestNumberRepo = RequestNumberRepository();
  }

  Function buildPageRoute(
    RouteSettings settings,
  ) {
    final blocProviders = <BlocProvider<Object?>>[
      BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(authRepo: authRepo),
      ),
      BlocProvider<LoginCubit>(
        create: (context) => LoginCubit(authRepository: authRepo),
      ),
      BlocProvider<SignUpCubit>(
        create: (context) => SignUpCubit(authRepository: authRepo),
      ),
    ];

    return (
      child, {
      fullScreen = false,
    }) =>
        MaterialPageRoute<void>(
          fullscreenDialog: fullScreen,
          builder: (context) => MultiBlocProvider(
            providers: blocProviders,
            child: child,
          ),
          settings: settings,
        );
  }

  Route<dynamic> generateRoute(
    RouteSettings settings,
  ) {
    final route = buildPageRoute(settings);

    switch (settings.name) {
      case ROOT:
        return route(RootPage()) as Route;
      case ENTER:
        return route(PageViewController()) as Route;
      case TAB_BAR_PAGE:
        return route(TabBarPage()) as Route;
      default:
        return unknownRoute(settings);
    }
  }

  Route<PageRouteBuilder> unknownRoute(
    RouteSettings settings,
  ) {
    final unknownRouteText = 'No such screen for ${settings.name}';

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(unknownRouteText),
          const Padding(padding: EdgeInsets.all(10)),
          ElevatedButton(
            child: const Text('Назад'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
