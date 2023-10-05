import 'package:bot_app/models/flat.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class FlatRepository {
  FlatRepository();

  static const int queryLimit = 1000000;

  Future<List<Flat>> getFlatList() async {
    print('... getFlatList() called');
    final QueryBuilder query = QueryBuilder<Flat>(Flat());
    query.setLimit(queryLimit);
    final q = await query.query();

    final qResults = q.results;

    if (qResults != null) {
      final list = qResults.map((dynamic flat) => flat as Flat).toList();
      return list;
    }
    throw 'getFlatList throw';
  }

  Future<List<Flat>> flatListForHouse({
    required String houseId,
  }) async {
    print('... getFlatListForHouse() called');
    final QueryBuilder query = QueryBuilder<Flat>(Flat());
    query
      ..setLimit(queryLimit)
      ..whereEqualTo(Flat.keyHouseId, houseId);

    final q = await query.query();
    final qResults = q.results;

    if (qResults != null) {
      final list = qResults.map((dynamic flat) => flat as Flat).toList();
      return list;
    }
    throw 'getFlatListForHouse throw';
  }

  Future<Flat?> flatByAccount({
    required String accountId,
  }) async {
    print('... getFlatByAccount() called');
    final flatList = await this.getFlatList();
    Flat? _flat;

    flatList.forEach((flat) {
      if (flat.accountIdList != null) {
        final flatAccountIdList =
            flat.accountIdList!.map((dynamic id) => id as String).toList();
        if (flatAccountIdList.contains(accountId)) {
          _flat = flat;
        }
      } else {
        return;
      }
    });
    return _flat;
  }
}
