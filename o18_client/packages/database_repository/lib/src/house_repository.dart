import 'dart:developer';

import 'package:model_repository/model_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class HouseRepository {
  HouseRepository();

  static const int queryLimit = 1000000;

  Future<List<House>> getHouseList() async {
    log(
      'getHousesList() called',
      name: 'HouseRepository',
    );
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

  Future<House> getHouseByFlat({
    required Flat flat,
  }) async {
    log(
      'getHouseByFlat() called',
      name: 'HouseRepository',
    );
    final houseList = await getHouseList();
    final house = houseList.firstWhere((house) {
      final houseFlatIdList = house.flatIdList;

      if (houseFlatIdList != null) {
        /// need to hard cast `e` to `String` because ParseServer objects doesn't support type safety
        final list = houseFlatIdList.map((dynamic e) => e as String).toList();
        return list.contains(flat.objectId);
      }
      throw 'getHouseByFlat throw';
    });
    return house;
  }
}
