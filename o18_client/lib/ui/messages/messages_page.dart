import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_client/cubits/message_cubit/message_cubit.dart';
import 'package:o18_client/helper/helper.dart';
import 'package:o18_client/ui/messages/messages_detail_page.dart';
import 'package:storage_repository/storage_repository.dart';

class MessagesPage extends StatefulWidget {
  @override
  _MessagesController createState() => _MessagesController();
}

class _MessagesController extends State<MessagesPage> {
  String houseId = '';

  @override
  void initState() {
    houseId = StorageRepository.getString(keyTopic);
    FlutterAppBadger.removeBadge();
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        body: _buildBody(context),
      );

  Widget _buildBody(
    BuildContext context,
  ) =>
      BlocBuilder<MessageCubit, MessageState>(
        builder: (context, state) {
          if (state is MessageLoading) {
            return const LinearProgressIndicator();
          } else if (state is MessageLoadFailure) {
            return Center(
              child: Text('Ошибка: ${state.error}'),
            );
          } else if (state is MessageLoaded) {
            if (state.messageList.isEmpty) {
              return const Center(child: Text('Сообщений пока не поступало...'));
            }

            return ListView.builder(
              itemCount: state.messageList.length,
              itemBuilder: (context, index) => _buildListItem(
                context: context,
                message: state.messageList[index],
              ),
            );
          } else if (state is MessageWasRead) {
            if (state.messageList.isEmpty) {
              return const Center(child: Text('Сообщений пока не поступало...'));
            }

            return ListView.builder(
              itemCount: state.messageList.length,
              itemBuilder: (context, index) => _buildListItem(
                context: context,
                message: state.messageList[index],
              ),
            );
          }

          return const Center(child: Text('Сообщений пока не поступало...'));
        },
      );

  Widget _buildListItem({
    required BuildContext context,
    required ParseMessage message,
  }) =>
      ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: message.wasSeen! ? const Icon(Icons.mail_outline) : const Icon(Icons.mail),
        ),
        title: Text(
          message.title ?? 'Нет заголовка',
          maxLines: 2,
          style: TextStyle(
            fontWeight: message.wasSeen! ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Text(message.body!, maxLines: 2),
        onTap: () {
          context.read<MessageCubit>().updateMessage(message: message);
          _navigateToDetailRequestPage(context: context, message: message);
        },
      );

  void _navigateToDetailRequestPage({
    required BuildContext context,
    required ParseMessage message,
  }) =>
      Navigator.push<void>(
        context,
        MaterialPageRoute(
          builder: (context) => MessageDetailPage(message: message),
        ),
      );
}
