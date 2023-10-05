import 'package:bot_app/models/account.dart';
import 'package:bot_app/models/house.dart';
import 'package:bot_app/models/owner.dart';
import 'package:bot_app/repositories/flat_repository.dart';
import 'package:bot_app/repositories/house_repository.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class AccountRepository {
  AccountRepository();

  static const int queryLimit = 1000000;

  Future<List<Account>> getAccountList() async {
    print('... getAccountList() called');
    final QueryBuilder query = QueryBuilder<Account>(Account());
    query.setLimit(queryLimit);
    final q = await query.query();

    final qResults = q.results;
    if (qResults != null) {
      final list = qResults.map((dynamic acc) => acc as Account).toList();

      return list;
    }

    return [];
  }

  Future<List<Account>> accountListForFlat({
    required String flatId,
  }) async {
    print('... getAccountListForFlat() called');
    final QueryBuilder query = QueryBuilder<Account>(Account());
    query
      ..setLimit(queryLimit)
      ..whereEqualTo(Account.keyFlatId, flatId);

    final q = await query.query();
    final qResults = q.results;

    if (qResults != null) {
      final list = qResults.map((dynamic acc) => acc as Account).toList();

      return list;
    }

    throw 'getAccountListForFlat throw';
  }

  Future<List<Account>> accountsListByAddress({
    required String address,
    required String flatNumber,
    required HouseRepository houseRepository,
    required FlatRepository flatRepository,
  }) async {
    print('... getAccountsListByAddress() called');

    final housesList = await houseRepository.houseList();
    final house = housesList.firstWhere(
        (house) => 'ул.${house.street}, д.${house.houseNumber}' == address);
    final flatList =
        await flatRepository.flatListForHouse(houseId: house.objectId!);
    final flat = flatList.firstWhere((flat) => flat.flatNumber == flatNumber);

    final accountList = await accountListForFlat(flatId: flat.objectId!);

    return accountList;
  }

  Future<bool> isAccountExist({
    required String accountNumber,
  }) async {
    final accountList = await getAccountList();
    return accountList.any((account) => account.accountNumber == accountNumber);
  }

  Future<Account> accountByOwner({
    required Owner owner,
  }) async {
    print('... getAccountByOwner() called');
    final accountList = await getAccountList();
    final account = accountList.firstWhere((account) {
      final accOwnerIdList = account.ownerIdList;

      if (accOwnerIdList != null) {
        /// need to hard cast `e` to `String` because ParseServer objects doesn't support type safety
        final list = accOwnerIdList.map((dynamic e) => e as String).toList();

        return list.contains(owner.objectId);
      }
      throw 'getAccountByOwner throw';
    });

    return account;
  }

  Future<Account> accountByAccountNumber({
    required String accountNumber,
  }) async {
    print('... getAccountByOwner() called');
    final accountList = await this.getAccountList();
    final account = accountList
        .firstWhere((account) => account.accountNumber == accountNumber);

    return account;
  }
}
