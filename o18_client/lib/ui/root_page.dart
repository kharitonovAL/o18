import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:o18_client/cubits/auth_cubit/auth_cubit.dart';
import 'package:o18_client/ui/login/page_view_controller.dart';
import 'package:o18_client/ui/tab_bar_page.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    context.read<AuthCubit>().appStarted();
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      BlocBuilder<AuthCubit, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return TabBarPage();
          }

          return PageViewController();
        },
      );

  Widget buildWaitingScreen() => Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
      );
}
