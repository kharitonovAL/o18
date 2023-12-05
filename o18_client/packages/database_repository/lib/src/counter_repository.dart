import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:database_repository/database_repository.dart';
import 'package:model_repository/model_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class CounterRepository {
  CounterRepository();

  static const int queryLimit = 1000000;

  Future<List<Counter>?> counterList({
    required AuthRepository authRepo,
    required OwnerRepository ownerRepository,
    required AccountRepository accountRepository,
    required FlatRepository flatRepository,
  }) async {
    log(
      '... getCounterList() called',
      name: 'CounterRepository',
    );
    final user = await authRepo.currentUser();
    final owner = await ownerRepository.getOwnerByEmail(email: user!.emailAddress!);
    final account = await accountRepository.getAccountByOwner(owner: owner!);
    final flat = await flatRepository.getFlatByAccount(accountId: account.objectId!);

    final QueryBuilder query = QueryBuilder<Counter>(Counter());
    query.setLimit(queryLimit);
    final q = await query.query();
    final qResults = q.results;

    if (qResults != null) {
      final list = qResults.map((dynamic counter) => counter as Counter).toList();
      list.retainWhere((counter) => counter.flatId == flat!.objectId);
      return list;
    }

    return null;
  }
}
