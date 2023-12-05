import 'dart:developer';
import 'dart:io';

import 'package:auth_repository/auth_repository.dart';
import 'package:database_repository/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:model_repository/model_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:storage_repository/storage_repository.dart';

class UserRequestRepository {
  UserRequestRepository();

  static const int queryLimit = 1000000;

  // QueryBuilder getUserRequestQuery() {
  //   log('... getUserRequestQuery() called');
  //   final QueryBuilder query = QueryBuilder<UserRequest>(UserRequest());
  //   query.orderByDescending(UserRequest.keyRequestNumber);
  //   query.setLimit(1000);
  //   return query;
  // }

  Future<Subscription<ParseObject>> subscribeOnEvents({
    required QueryBuilder query,
  }) async {
    log(
      'subscribeOnEvents() called',
      name: 'UserRequestRepository',
    );
    final liveQuery = LiveQuery();
    final subscription = await liveQuery.client.subscribe(query);

    return subscription;
  }

  Future<void> unsubscribeFromEvents({
    required QueryBuilder query,
  }) async {
    log(
      'unsubscribeOnEvents() called',
      name: 'UserRequestRepository',
    );
    final liveQuery = LiveQuery();
    final subscription = await liveQuery.client.subscribe(query);
    liveQuery.client.unSubscribe(subscription);
  }

  Future<List<UserRequest>?> getUserRequestList({
    required AccountRepository accountRepository,
    required AuthRepository authRepo,
    required OwnerRepository ownerRepository,
  }) async {
    log(
      'getUserRequestList() called',
      name: 'UserRequestRepository',
    );
    final QueryBuilder query = QueryBuilder<UserRequest>(UserRequest());
    query.setLimit(queryLimit);

    final q = await query.query();
    final qResults = q.results;

    if (qResults != null) {
      final list = qResults.map((dynamic request) => request as UserRequest).toList();
      final account = await accountRepository.getAccountForCurrentUser(
        authRepo: authRepo,
        ownerRepository: ownerRepository,
      );

      list.retainWhere((request) => request.accountNumber == account.accountNumber);
      list.sort((a, b) {
        final aDate = a.requestDate;
        final bDate = b.requestDate;

        if (aDate != null && bDate != null) {
          return bDate.compareTo(aDate);
        }
        throw 'getUserRequestList date sorting throw';
      });

      return list;
    }

    return null;
  }

  Future<bool> sendRequest({
    required int requestNumber,
    required AuthRepository authRepo,
    required OwnerRepository ownerRepository,
    required AccountRepository accountRepository,
    required FlatRepository flatRepository,
    required HouseRepository houseRepository,
    required TextEditingController textController,
    required RequestNumberRepository requestNumberRepository,
    required ImageRepository imageFileRepository,
    required File? image1,
    required File? image2,
    required File? image3,
    required File? image4,
    required File? image5,
    required String keyToken,
  }) async {
    log(
      'sendRequest() called',
      name: 'UserRequestRepository',
    );

    final user = await authRepo.currentUser();
    final owner = await ownerRepository.getOwnerByEmail(email: user!.emailAddress!);
    final account = await accountRepository.getAccountByOwner(owner: owner!);
    final flat = await flatRepository.getFlatByAccount(accountId: account.objectId!);
    final house = await houseRepository.getHouseByFlat(flat: flat!);
    final address = 'улица ${house.street}, ${house.houseNumber}';

    final today = DateTime.now().toLocal();
    final responseDate = today.hour < 12
        ? DateTime(today.year, today.month, today.day, 17)
        : DateTime(today.year, today.month, today.day, 12).add(const Duration(days: 1));

    final userRequest = UserRequest();

    userRequest
      ..userRequest = textController.text
      ..requestDate = DateTime.now().toLocal()
      ..responseDate = responseDate
      ..status = RS.received
      ..accountNumber = account.accountNumber
      ..address = address
      ..flatNumber = flat.flatNumber
      ..author = 'Приложение'
      ..phoneNumber = owner.phoneNumber.toString()
      ..userName = owner.name
      ..requestNumber = requestNumber
      ..userUid = user.objectId
      ..requestType = RS.received
      ..wasSeen = false
      ..partnerId = '2wcA3IkW76'
      ..ownerId = owner.objectId
      ..debt = account.debt
      ..userToken = StorageRepository.getString(keyToken);

    final response = await userRequest.save();

    if (response.success) {
      if (response.results != null) {
        final uRequestList = response.results!.map((dynamic ur) => ur as UserRequest).toList();

        if (uRequestList.isNotEmpty) {
          final uRequest = uRequestList.first;
          final requestId = uRequest.objectId!;

          if (image1 != null) {
            await imageFileRepository.loadImage(
              image: image1,
              requestId: requestId,
            );
          }
          if (image2 != null) {
            await imageFileRepository.loadImage(
              image: image2,
              requestId: requestId,
            );
          }
          if (image3 != null) {
            await imageFileRepository.loadImage(
              image: image3,
              requestId: requestId,
            );
          }
          if (image4 != null) {
            await imageFileRepository.loadImage(
              image: image4,
              requestId: requestId,
            );
          }
          if (image5 != null) {
            await imageFileRepository.loadImage(
              image: image5,
              requestId: requestId,
            );
          }

          await requestNumberRepository.incrementRequestNumber();
          return true;
        } else {
          log(
            'uRequestList is empty',
            name: 'UserRequestRepository',
          );
        }
      } else {
        log(
          'response.results is null',
          name: 'UserRequestRepository',
        );
      }
    }

    return false;
  }
}
