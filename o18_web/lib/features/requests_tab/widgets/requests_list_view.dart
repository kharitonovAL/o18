import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/request_editor/request_editor.dart';
import 'package:o18_web/features/requests_tab/widgets/widgets.dart';

class RequestsListView extends StatelessWidget {
  final List<UserRequest> list;
  final User user;

  const RequestsListView({
    required this.list,
    required this.user,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) => RequestTableItem(
          request: list[index],
          itemIndex: index,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => RequestEditorCubit(
                  userRequest: list[index],
                  user: user,
                ),
                child: RequestEditorPage(
                  userRequest: list[index],
                ),
              ),
            ),
          ),
        ),
      );
}
