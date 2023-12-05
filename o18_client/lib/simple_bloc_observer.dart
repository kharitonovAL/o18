import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(
    BlocBase cubit,
  ) {
    super.onCreate(cubit);
    log(
      'onCreate -- cubit: ${cubit.runtimeType}',
      name: 'SimpleBlocObserver',
    );
  }

  @override
  void onEvent(
    Bloc bloc,
    Object? event,
  ) {
    super.onEvent(bloc, event);
    log(
      'onEvent -- bloc: ${bloc.runtimeType}, event: $event',
      name: 'SimpleBlocObserver',
    );
  }

  @override
  void onChange(
    BlocBase cubit,
    Change change,
  ) {
    super.onChange(cubit, change);
    log(
      'onChange -- cubit: ${cubit.runtimeType}, change: $change',
      name: 'SimpleBlocObserver',
    );
  }

  @override
  void onTransition(
    Bloc bloc,
    Transition transition,
  ) {
    super.onTransition(bloc, transition);
    log(
      'onTransition -- bloc: ${bloc.runtimeType}, transition: $transition',
      name: 'SimpleBlocObserver',
    );
  }

  @override
  void onError(
    BlocBase cubit,
    Object error,
    StackTrace stackTrace,
  ) {
    log(
      'onError -- cubit: ${cubit.runtimeType}, error: $error',
      name: 'SimpleBlocObserver',
      stackTrace: stackTrace,
    );
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onClose(
    BlocBase cubit,
  ) {
    super.onClose(cubit);
    log(
      'onClose -- cubit: ${cubit.runtimeType}',
      name: 'SimpleBlocObserver',
    );
  }
}
