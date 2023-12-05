import 'dart:developer';

import 'package:database_repository/database_repository.dart';
import 'package:model_repository/model_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class OwnerRepository {
  OwnerRepository();

  static const int queryLimit = 1000000;

  Future<Owner> getOwnerByPhoneNumber({
    required int phoneNumber,
  }) async {
    log(
      'getOwnerByPhoneNumber() called',
      name: 'OwnerRepository',
    );
    final QueryBuilder query = QueryBuilder<Owner>(Owner());
    query.setLimit(queryLimit);
    final q = await query.query();
    final qResults = q.results;

    if (qResults != null) {
      final list = qResults.map((dynamic owner) => owner as Owner).toList();

      if (list.isEmpty) {
        throw 'getOwnerByPhoneNumber list is empty throw';
      }

      final owner = list.firstWhere((owner) => owner.phoneNumber == phoneNumber);
      return owner;
    }
    throw 'getOwnerByPhoneNumber throw';
  }

  Future<Owner?> getOwnerByEmail({
    required String email,
  }) async {
    log(
      'getOwnerByEmail() called',
      name: 'OwnerRepository',
    );
    final QueryBuilder query = QueryBuilder<Owner>(Owner());
    query.setLimit(queryLimit);
    final q = await query.query();
    final qResults = q.results;

    if (qResults != null) {
      final list = qResults.cast<Owner>();
      final owner = list.firstWhere((owner) => owner.email == email);
      return owner;
    }
    return null;
  }

  Future<List<Owner>> getOwnerListByAccountNumber({
    required String accountNumber,
    required AccountRepository accountRepository,
  }) async {
    log(
      'getOwnerByAccountNumber() called',
      name: 'OwnerRepository',
    );
    final QueryBuilder query = QueryBuilder<Owner>(Owner());
    query.setLimit(queryLimit);
    final q = await query.query();
    final qResults = q.results;
    final accountList = await accountRepository.getAccountList();

    // This check needed to prevent wrong account number input on sign up page
    final isAccountNumberExist = accountList.any((account) => account.accountNumber == accountNumber);
    if (!isAccountNumberExist) {
      return [];
    }

    final account = accountList.firstWhere((acc) => acc.accountNumber == accountNumber);

    final ownerIdList = account.ownerIdList!.map((dynamic id) => id as String).toList();

    if (qResults != null) {
      final ownerList = qResults.map((dynamic owner) => owner as Owner).toList();
      if (ownerList.isEmpty) {
        throw 'getOwnerByAccountNumber list is empty throw';
      }
      final relatedOwnerList = <Owner>[];

      ownerIdList.forEach((ownerId) {
        final owner = ownerList.firstWhere((owner) => owner.objectId == ownerId);
        relatedOwnerList.add(owner);
      });

      return relatedOwnerList;
    }
    return [];
  }

  Future<bool> isOwnerRegistered({
    required String ownerId,
  }) async {
    log(
      'isOwnerRegistered() called',
      name: 'OwnerRepository',
    );

    final QueryBuilder query = QueryBuilder<Owner>(Owner());
    query.setLimit(queryLimit);
    final q = await query.query();
    final qResults = q.results;

    if (qResults != null) {
      final ownerList = qResults.map((dynamic owner) => owner as Owner).toList();
      final isOwnerRegistered = ownerList.any((owner) => owner.objectId == ownerId);
      return isOwnerRegistered;
    }

    return false;
  }
}
