import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_web/app/bloc/app_bloc.dart';
import 'package:o18_web/app/routes/routes.dart';
import 'package:o18_web/features/counters_tab/cubit/counters_tab_cubit.dart';
import 'package:o18_web/features/houses_tab/cubit/cubit.dart';
import 'package:o18_web/features/partners_tab/cubit/cubit.dart';
import 'package:o18_web/features/requests_tab/cubit/cubit.dart';
import 'package:o18_web/theme/theme.dart';

class App extends StatelessWidget {
  const App({
    required AuthenticationRepository authenticationRepository,
    Key? key,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(
    BuildContext context,
  ) =>
      RepositoryProvider.value(
        value: _authenticationRepository,
        child: BlocProvider(
          create: (_) => AppBloc(
            authenticationRepository: _authenticationRepository,
          ),
          child: const AppView(),
        ),
      );
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) =>
      ScreenUtilInit(
        designSize: const Size(1920, 1080),
        builder: (context, widget) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => RequestsTabCubit(),
            ),
            BlocProvider(
              create: (context) => SortingCubit(),
            ),
            BlocProvider(
              create: (context) => HousesTabCubit(),
            ),
            BlocProvider(
              create: (context) => CountersTabCubit(),
            ),
            BlocProvider(
              create: (context) => PartnersTabCubit(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            home: widget,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ru', 'RU'),
            ],
          ),
        ),
        child: FlowBuilder<AuthenticationStatus>(
          // ignore: avoid_types_on_closure_parameters
          state: context.select((AppBloc bloc) => bloc.state.status),
          onGeneratePages: onGenerateAppViewPages,
        ),
      );
}
