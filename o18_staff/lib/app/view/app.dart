import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_staff/app/routes/routes.dart';
import 'package:o18_staff/app/store/app_store.dart';
import 'package:o18_staff/theme/theme.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) =>
      ScreenUtilInit(
        designSize: Platform.isAndroid ? const Size(414, 793) : const Size(414, 844),
        builder: (context, widget) => MaterialApp(
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
        child: Observer(
          builder: (_) {
            final appStore = Provider.of<AppStore>(context);

            return FlowBuilder<AuthenticationStatus>(
              // ignore: avoid_types_on_closure_parameters
              state: appStore.status,
              onGeneratePages: onGenerateAppViewPages,
            );
          },
        ),
      );
}
