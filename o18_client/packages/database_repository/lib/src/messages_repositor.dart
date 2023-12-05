// ignore_for_file: implementation_imports

import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:database_repository/database_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:model_repository/model_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:storage_repository/storage_repository.dart';

class MessagesRepository {
  static const int queryLimit = 1000000;

  Future<List<ParseMessage>> getMessageListForOwner({
    required String ownerId,
  }) async {
    log(
      'getMessagesForOwner() called',
      name: 'MessagesRepository',
    );
    final QueryBuilder query = QueryBuilder<ParseMessage>(ParseMessage());
    query.setLimit(queryLimit);
    final q = await query.query();
    final qResults = q.results;

    if (qResults != null) {
      final list = qResults.map((dynamic msg) => msg as ParseMessage).toList();

      list.retainWhere((msg) => msg.ownerId == ownerId);
      list.sort((a, b) {
        final aDate = a.date;
        final bDate = b.date;

        if (aDate != null && bDate != null) {
          return aDate.compareTo(bDate);
        }
        throw 'getMessageListForOwner sort list throw';
      });

      return list;
    }

    return [];
  }

  Future<List<ParseMessage>> getMessageListForHouse({
    required String houseId,
  }) async {
    log(
      'getMessageListForHouse() called',
      name: 'MessagesRepository',
    );
    final QueryBuilder query = QueryBuilder<ParseMessage>(ParseMessage());
    query.setLimit(queryLimit);
    final q = await query.query();
    final qResults = q.results;

    if (qResults != null) {
      final list = qResults.map((dynamic msg) => msg as ParseMessage).toList();
      list.retainWhere((msg) => msg.houseId == houseId);
      list.sort((a, b) {
        final aDate = a.date;
        final bDate = b.date;

        if (aDate != null && bDate != null) {
          return aDate.compareTo(bDate);
        }
        throw 'getMessageListForHouse sort list throw';
      });

      return list;
    }

    return [];
  }

  Future<void> updateMessageWasSeenDate({
    required ParseMessage message,
  }) async {
    log(
      'updateMessageWasSeenDate() called',
      name: 'MessagesRepository',
    );

    if (message.wasSeenDate == null || (message.wasSeen != null && !message.wasSeen!)) {
      log(
        'message not seen yet',
        name: 'MessagesRepository',
      );

      message.wasSeenDate = DateTime.now().toLocal();
      message.wasSeen = true;
      await message.update().then(
            (value) => log(
              'message was ${value.success ? '' : 'NOT'} updated',
              name: 'MessagesRepository',
            ),
          );
    } else {
      log(
        'message was seen on ${message.wasSeenDate}',
        name: 'MessagesRepository',
      );
    }
  }

  Future<bool> unsubscribeFromTopic(
    String keyTopic,
    FirebaseMessaging firebaseMessagingInstance,
  ) async {
    log(
      'unsubscribeFromTopic() called',
      name: 'MessagesRepository',
    );
    final topic = StorageRepository.getString(keyTopic);
    if (topic.isNotEmpty) {
      await firebaseMessagingInstance.unsubscribeFromTopic(topic);
    }

    return true;
  }

  Future<bool?> deleteDeviceToken({
    required AuthRepository authRepository,
    required OwnerRepository ownerRepository,
    required String keyToken,
  }) async {
    log(
      'deleteDeviceToken() called',
      name: 'MessagesRepository',
    );
    final token = StorageRepository.getString(keyToken);

    final user = await authRepository.currentUser();

    if (user != null) {
      final owner = await ownerRepository.getOwnerByEmail(
        email: user.emailAddress!,
      );

      // fo some reason `deviceTokenList` has to be inialized here,
      // not before line: `if (deviceTokenList.length == 1) _owner!.isRegistered = false;`
      final deviceTokenList = owner!.deviceTokenList!.map((dynamic e) => '$e').toList();
      owner.setRemove(Owner.keyDeviceTokenList, token);

      // if there is only one user device (length == 1), set `isRegistered` to false, becase user is no longer able to
      // recieve push notifications

      if (deviceTokenList.length == 1) {
        owner.isRegistered = false;
      }
      final result = await owner.update();

      return result.success;
    }

    return null;
  }
}
