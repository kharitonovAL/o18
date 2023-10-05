// ignore_for_file: avoid_types_on_closure_parameters
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:o18_web/app/bloc/app_bloc.dart';
import 'package:o18_web/features/counters_tab/view/view.dart';
import 'package:o18_web/features/houses_tab/view/houses_tab_view.dart';
import 'package:o18_web/features/partners_tab/view/view.dart';
import 'package:o18_web/features/request_editor/cubit/cubit.dart';
import 'package:o18_web/features/request_editor/view/request_editor_page.dart';
import 'package:o18_web/features/requests_tab/view/requests_tab_view.dart';
import 'package:o18_web/features/tab_page/widgets/widgets.dart';
import 'package:o18_web/utils/utils.dart';

class TabView extends StatefulWidget {
  static Page page() => MaterialPage(child: TabView());

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with TickerProviderStateMixin {
  TabController? _tabController;
  final _searchRequestController = TextEditingController();
  final _searchHouseController = TextEditingController();
  final _searchCounterController = TextEditingController();
  final _searchPartnerController = TextEditingController();

  User? _user;

  @override
  void initState() {
    _tabController = TabController(
      length: 4,
      vsync: this,
    );

    _user = context.read<AppBloc>().state.user;

    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        appBar: AppTabBar(
          controller: _tabController!,
        ),
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            RequestsTab(
              user: _user!,
              textController: _searchRequestController,
              onNewRequestPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => RequestEditorCubit(
                      user: _user,
                      requestSelection: RequestSelection.newReques,
                    ),
                    child: const RequestEditorPage(
                      requestSelection: RequestSelection.newReques,
                    ),
                  ),
                ),
              ),
            ),
            HousesTabView(
              textController: _searchHouseController,
              user: _user!,
            ),
            CountersTabView(
              textController: _searchCounterController,
            ),
            PartnersTabView(
              textController: _searchPartnerController,
            ),
          ],
        ),
      );
}
