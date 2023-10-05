import 'package:bot_app/models/owner.dart';
import 'package:bot_app/repositories/account_repository.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class OwnerRepository {
  OwnerRepository();

  static const int queryLimit = 1000000;

  Future<Owner> ownerByPhoneNumber({
    required int phoneNumber,
  }) async {
    print('... getOwnerByPhoneNumber() called');
    final QueryBuilder query = QueryBuilder<Owner>(Owner());
    query.setLimit(queryLimit);
    final q = await query.query();
    final qResults = q.results;

    if (qResults != null) {
      final list = qResults.map((dynamic owner) => owner as Owner).toList();

      if (list.isEmpty) {
        throw 'getOwnerByPhoneNumber list is empty throw';
      }

      final owner =
          list.firstWhere((owner) => owner.phoneNumber == phoneNumber);
      return owner;
    }
    throw 'getOwnerByPhoneNumber throw';
  }

  Future<Owner> ownerByEmail({
    required String email,
  }) async {
    print('... getOwnerByEmail() called');
    final QueryBuilder query = QueryBuilder<Owner>(Owner());
    query.setLimit(queryLimit);
    final q = await query.query();
    final qResults = q.results;

    if (qResults != null) {
      final list = qResults.cast<Owner>();
      final owner = list.firstWhere((owner) => owner.email == email);
      return owner;
    }

    throw 'getOwnerByEmail throw';
  }

  Future<List<Owner>> getOwnerListByAccountNumber({
    required String accountNumber,
    required AccountRepository accountRepository,
  }) async {
    print('... getOwnerByAccountNumber() called');
    final QueryBuilder query = QueryBuilder<Owner>(Owner());
    query.setLimit(queryLimit);
    final q = await query.query();
    final qResults = q.results;
    final accountList = await accountRepository.getAccountList();

    // This check needed to prevent wrong account number input on sign up page
    final isAccountNumberExist =
        accountList.any((account) => account.accountNumber == accountNumber);
    if (!isAccountNumberExist) {
      return [];
    }

    final account =
        accountList.firstWhere((acc) => acc.accountNumber == accountNumber);

    final ownerIdList =
        account.ownerIdList!.map((dynamic id) => id as String).toList();

    if (qResults != null) {
      final ownerList =
          qResults.map((dynamic owner) => owner as Owner).toList();
      if (ownerList.isEmpty) {
        throw 'getOwnerByAccountNumber list is empty throw';
      }
      var relatedOwnerList = <Owner>[];

      ownerIdList.forEach((ownerId) {
        final owner =
            ownerList.firstWhere((owner) => owner.objectId == ownerId);
        relatedOwnerList.add(owner);
      });

      return relatedOwnerList;
    }
    return [];
  }

  Future<bool> isOwnerRegistered({
    required String ownerId,
  }) async {
    final QueryBuilder query = QueryBuilder<Owner>(Owner());
    query.setLimit(queryLimit);
    final q = await query.query();
    final qResults = q.results;

    if (qResults != null) {
      final ownerList =
          qResults.map((dynamic owner) => owner as Owner).toList();
      final isOwnerRegistered =
          ownerList.any((owner) => owner.objectId == ownerId);
      return isOwnerRegistered;
    }

    return false;
  }
}
