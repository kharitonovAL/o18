import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:model_repository/model_repository.dart';

class MessageDetailPage extends StatelessWidget {
  final ParseMessage message;

  MessageDetailPage({
    required this.message,
  });

  final dateFormat = DateFormat('dd.MM.yyyy');

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        appBar: AppBar(title: const Text('Сообщение')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Получено ${dateFormat.format(message.date!)}:',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Тема: ${message.title}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        '\nСообщение:\n${message.body}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
