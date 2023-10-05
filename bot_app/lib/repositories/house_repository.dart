import 'package:bot_app/models/flat.dart';
import 'package:bot_app/models/house.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class HouseRepository {
  HouseRepository();

  static const int queryLimit = 1000000;

  Future<List<House>> houseList() async {
    print('... getHousesList() called');
    final QueryBuilder query = QueryBuilder<House>(House());
    query.setLimit(queryLimit);

    final q = await query.query();
    final qResults = q.results;

    if (qResults != null) {
      final list = qResults.map((dynamic house) => house as House).toList();
      list.sort((a, b) {
        final aStreet = a.street;
        final bStreet = b.street;

        if (aStreet != null && bStreet != null) {
          return aStreet.compareTo(bStreet);
        }
        throw 'getHouseList street compatrion throw';
      });
      return list;
    }

    throw 'getHouseList throw';
  }

  Future<House?> houseByFlat({
    required Flat flat,
  }) async {
    print('... getHouseByFlat() called');
    final houseList = await this.houseList();
    House? _house;

    houseList.forEach((house) {
      if (house.flatIdList != null && house.flatIdList!.isNotEmpty) {
        final list = house.flatIdList!.map((dynamic e) => e as String).toList();
        if (list.contains(flat.objectId)) {
          _house = house;
        }
      }
    });
    return _house;
  }
}
