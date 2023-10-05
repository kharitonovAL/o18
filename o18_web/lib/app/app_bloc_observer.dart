import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log(
      'onCreate(${bloc.runtimeType})',
      name: 'AppBlocObserver',
    );
  }

  @override
  void onChange(
    BlocBase bloc,
    Change change,
  ) {
    super.onChange(bloc, change);
    log(
      'onChange(${bloc.runtimeType}, $change)',
      name: 'AppBlocObserver',
    );
  }

  @override
  void onError(
    BlocBase bloc,
    Object error,
    StackTrace stackTrace,
  ) {
    log(
      'onError(${bloc.runtimeType})',
      name: 'AppBlocObserver',
      error: error,
    );

    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(
  FutureOr<Widget> Function() builder,
) async {
  FlutterError.onError = (details) {
    print(details.exceptionAsString());

    log(
      'bootstrap',
      name: 'AppBlocObserver',
      error: details.exceptionAsString(),
      stackTrace: details.stack,
    );
  };

  Bloc.observer = AppBlocObserver();
  runApp(await builder());
}
