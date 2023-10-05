import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_client/features/messages/view/messages_view.dart';
import 'package:o18_client/features/requests/view/request_view.dart';
import 'package:o18_client/features/tab_page/store/tab_view_store.dart';
import 'package:o18_client/features/tab_page/widgets/widgets.dart';
import 'package:o18_client/theme/style/app_colors.dart';
import 'package:o18_client/utils/utils.dart';

class TabView extends StatefulWidget {
  static Page page() => MaterialPage(child: TabView());

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with TickerProviderStateMixin {
  final store = TabViewStore();
  final _pageController = PageController();

  static final List<Widget> _widgetOptions = [
    MessagesView(),
    RequestView(),
    Container(
      width: 100,
      height: 100,
      color: Colors.red,
    ),
    Container(
      width: 100,
      height: 100,
      color: Colors.amber,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      SafeArea( 
        child: Observer(
          builder: (_) => Scaffold(
            appBar: AppTabBar(),
            body: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                store.selectedIndex = index;
              },
              children: _widgetOptions,
            ),
            bottomNavigationBar: BottomNavigationBar(
              iconSize: 29.w,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.message_outlined),
                  label: TabViewString.messages,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.article_outlined),
                  label: TabViewString.requests,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.insert_chart_outlined_outlined),
                  label: TabViewString.counters,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_outlined),
                  label: TabViewString.profile,
                ),
              ],
              currentIndex: store.selectedIndex,
              selectedItemColor: AppColors.green_0,
              unselectedItemColor: AppColors.grey_2,
              onTap: (val) => store.onItemTapped(
                controller: _pageController,
                index: val,
              ),
            ),
          ),
        ),
      );
}
