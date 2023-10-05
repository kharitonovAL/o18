// ignore_for_file: implementation_imports

import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:model_repository/src/model/models.dart' as model;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class MessagesRepository {
  final int queryLimit = 1000000;

  Future<List<model.ParseMessage>> getMessageList({
    required String houseId,
  }) async {
    log(
      'getMessageList() called',
      name: 'MessagesRepository',
    );

    final QueryBuilder query =
        QueryBuilder<model.ParseMessage>(model.ParseMessage());
    query.setLimit(queryLimit);
    final q = await query.query();
    final list = q.results == null
        ? <model.ParseMessage>[]
        : q.results!.map((dynamic msg) => msg as model.ParseMessage).toList();
    list.retainWhere((msg) => msg.houseId == houseId);
    list.sort((a, b) => a.date!.compareTo(b.date!));
    return list;
  }

  /// Get messages that was sent to specific house and those messages will be shown
  /// in info card of the house
  Future<List<model.HouseMessage>> getMessageListForHouse({
    required String houseId,
  }) async {
    log(
      '... getMessageList() called',
      name: 'MessagesRepository',
    );

    final QueryBuilder query =
        QueryBuilder<model.HouseMessage>(model.HouseMessage());
    query.setLimit(queryLimit);
    final q = await query.query();
    final list = q.results == null
        ? <model.HouseMessage>[]
        : q.results!.map((dynamic msg) => msg as model.HouseMessage).toList();
    list.retainWhere((msg) => msg.houseId == houseId);
    list.sort((a, b) => a.date!.compareTo(b.date!));
    return list;
  }

  Future<List<model.StaffMessage>> getStaffMessageList({
    required String staffId,
  }) async {
    log(
      'getStaffMessageList() called',
      name: 'MessagesRepository',
    );

    final QueryBuilder query =
        QueryBuilder<model.StaffMessage>(model.StaffMessage());
    query.setLimit(queryLimit);
    final q = await query.query();
    final list = q.results == null
        ? <model.StaffMessage>[]
        : q.results!.map((dynamic msg) => msg as model.StaffMessage).toList();
    list.retainWhere((msg) => msg.staffId == staffId);
    list.sort((a, b) => a.date!.compareTo(b.date!));
    return list;
  }

  Future<List<model.ParseMessage>> getOwnerMessageList({
    required String ownerId,
  }) async {
    log(
      'getOwnerMessageList() called',
      name: 'MessagesRepository',
    );

    final QueryBuilder query =
        QueryBuilder<model.ParseMessage>(model.ParseMessage());
    query.setLimit(queryLimit);
    final q = await query.query();
    final list = q.results == null
        ? <model.ParseMessage>[]
        : q.results!.map((dynamic msg) => msg as model.ParseMessage).toList();
    list.retainWhere((msg) => msg.ownerId == ownerId);
    list.sort((a, b) => a.date!.compareTo(b.date!));
    return list;
  }

  void updateMessageWasSeenDate({
    required model.StaffMessage message,
  }) {
    log(
      'updateMessageWasSeenDate() called',
      name: 'MessagesRepository',
    );

    message.wasSeenDate = DateTime.now();
    message.update();
  }

  Future<bool> sendPushToTopic({
    required String body,
    required String houseId,
  }) async {
    await dotenv.load();

    final topic = houseId;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=${dotenv.env['FCM_SERVER_KEY']}'
    };
    final message = {
      'notification': {
        'title': 'Сообщение от УК',
        'body': body,
        'badge': 1,
        'sound': 'default'
      },
      'priority': 'high',
      'to': '/topics/$topic',
      'data': {'topic': topic}
    };

    final jsonBody = json.encode(message);
    final postResponse = await http.post(
      Uri.parse(dotenv.env['FCM_URL']!),
      headers: headers,
      body: jsonBody,
      encoding: Encoding.getByName('utf-8'),
    );

    var postResponseSuccess = false;

    // check if message was sent
    if (postResponse.statusCode == 200 ||
        postResponse.statusCode == 201 ||
        postResponse.statusCode == 202) {
      postResponseSuccess = true;
    }

    final houseMessage = model.HouseMessage();
    houseMessage
      ..title = 'Сообщение от УК'
      ..body = body
      ..date = DateTime.now()
      ..houseId = houseId;
    final houseMessageSaveResponse = await houseMessage.save();

    // final parseMessage = model.ParseMessage();
    // parseMessage
    //   ..title = 'Сообщение от УК'
    //   ..body = body
    //   ..date = DateTime.now()
    //   ..houseId = houseId
    //   ..wasSeen = false;
    // final parseMessageSaveResponse = await parseMessage.save();

    if (postResponseSuccess &&
        houseMessageSaveResponse.success
        // && parseMessageSaveResponse.success
        ) {
      return true;
    }
    return false;
  }

  Future<bool> sendPushToToken({
    required String title,
    required String message,
    required String token,
    String? houseId,
    String? ownerId,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=${dotenv.env['FCM_SERVER_KEY']}'
    };
    final body = {
      'notification': {
        'title': title,
        'body': message,
        'badge': 1,
        'sound': 'default'
      },
      'priority': 'high',
      'to': token
    };

    final jsonBody = json.encode(body);

    final postResponse = await http.post(
      Uri.parse(dotenv.env['FCM_URL']!),
      headers: headers,
      body: jsonBody,
      encoding: Encoding.getByName('utf-8'),
    );

    var postResponseSuccess = false;

    // check if message was sent
    if (postResponse.statusCode == 200 ||
        postResponse.statusCode == 201 ||
        postResponse.statusCode == 202) {
      postResponseSuccess = true;
    }

    final parseMessage = model.ParseMessage();
    parseMessage
      ..title = title
      ..body = message
      ..date = DateTime.now()
      ..houseId = houseId
      ..ownerId = ownerId
      ..token = token
      ..wasSeen = false;

    final parseMessageSaveResponse = await parseMessage.save();

    if (postResponseSuccess && parseMessageSaveResponse.success) {
      return true;
    }
    return false;
  }
}
