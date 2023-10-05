import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_client/features/login/store/login_store.dart';
import 'package:o18_client/features/messages/store/messages_store.dart';
import 'package:o18_client/features/messages/view/view.dart';
import 'package:o18_client/features/messages/widgets/widgets.dart';
import 'package:o18_client/features/widgets/widgets.dart';
import 'package:o18_client/utils/strings/messages_strings.dart';
import 'package:provider/provider.dart';

class MessagesView extends StatefulWidget {
  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  final _store = MessagesStore();
  final _textController = TextEditingController();
  late final Staff? _currentStaff;

  @override
  void initState() {
    FlutterAppBadger.removeBadge();

    _currentStaff = context.read<LoginStore>().currentStaff;

    if (_currentStaff != null) {
      _store.loadMessageList(staffId: _currentStaff!.objectId!);
    }

    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      Observer(
        builder: (_) => Padding(
          padding: EdgeInsets.only(
            top: 20.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SearchField(
                  title: MessagesString.search,
                  textController: _textController,
                  width: 374, // don't add '.w', cause it assigned inside widget
                  onChanged: (query) {
                    _store.searchRequest(query: query);
                  },
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: _store.messageList.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Scrollbar(
                        child: ListView.builder(
                          itemCount: _store.messageList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(
                              bottom: 10.h,
                              left: 20.w,
                              right: 20.w,
                            ),
                            child: MessageListItem(
                              message: _store.messageList[index],
                              onTap: () => Navigator.of(context)
                                  .push(
                                    MaterialPageRoute(
                                      builder: (context) => Provider<MessagesStore>(
                                        create: (_) => MessagesStore(),
                                        child: MessageDetailView(
                                          message: _store.messageList[index],
                                        ),
                                      ),
                                    ),
                                  )
                                  .whenComplete(
                                    () => _store.loadMessageList(
                                      staffId: _currentStaff!.objectId!,
                                    ),
                                  ),
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      );
}
