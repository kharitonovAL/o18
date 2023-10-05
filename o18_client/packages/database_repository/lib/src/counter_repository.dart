// ignore_for_file: implementation_imports, avoid_function_literals_in_foreach_calls

import 'dart:developer';

import 'package:database_repository/src/flat_repositor.dart';
import 'package:model_repository/src/model/models.dart' as model;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CounterRepository {
  final int queryLimit = 1000000;
  final flatRepository = FlatRepository();

  Future<List<model.Counter>> getCounterList() async {
    log(
      'getCounterList() called',
      name: 'CounterRepository',
    );

    final QueryBuilder query = QueryBuilder<model.Counter>(model.Counter());
    query.setLimit(queryLimit);
    final q = await query.query();
    final list = q.results == null
        ? <model.Counter>[]
        : q.results!
            .map((dynamic counter) => counter as model.Counter)
            .toList();
    return list;
  }

  Future<void> removeCounterWithSerialNumber({
    required String serialNumber,
  }) async {
    log(
      'removeCounterWithSerialNumber() called',
      name: 'CounterRepository',
    );

    final counterList = await getCounterList();
    final flatList = await flatRepository.getFlatList();

    final counter = counterList
        .firstWhere((counter) => counter.serialNumber == serialNumber);
    await counter.delete();

    flatList.forEach((flat) {
      final counterIdList =
          flat.accountIdList!.map((dynamic e) => e as String).toList();
      if (counterIdList.contains(counter.objectId)) {
        flat.setRemove(model.Flat.keyCounterIdList, counter.objectId);
        flat.update();
      }
    });
  }

  Future<List<model.Counter>> getRegisteredCounterList() async {
    log(
      'getRegisteredCounterList() called',
      name: 'CounterRepository',
    );

    final flatList = await flatRepository.getFlatList();
    final counterList = await getCounterList();

    final counterIdList = <String>[];
    final resultList = <model.Counter>[];

    flatList.forEach((flat) {
      final idList =
          flat.counterIdList!.map((dynamic e) => e as String).toList();
      if (idList.isNotEmpty) {
        counterIdList.addAll(idList);
      }
    });

    counterIdList.forEach((id) {
      final counter = counterList.firstWhere((c) => c.objectId == id);
      resultList.add(counter);
    });

    return resultList;
  }

  // user this method to set counter addresses

  // Future setCounterAddress() async {
  //   final houseRepo = HouseRepository();
  //   final flatList = await flatRepository.getFlatList();
  //   final houseList = await houseRepo.getHouseList();
  //   final counterList = await getCounterList();

  //   flatList.forEach((flat) {
  //     if (flat.accountIdList!.isNotEmpty) {
  //       log('flat.accountIdList.isNotEmpty, flatId: ${flat.objectId}');
  //       final counterIdList =
  //           flat.counterIdList!.map((dynamic e) => e as String).toList();

  //       log(counterIdList.length.toString());

  //       counterIdList.forEach((counterId) {
  //         final counter =
  //             counterList.firstWhere((c) => c.objectId == counterId);
  //         log(counter.objectId!);

  //         final house = houseList.firstWhere((h) => h.objectId == flat.houseId);
  //         final address = 'ул.${house.street} кв.${flat.flatNumber}';
  //         log(address);
  //         counter.address = address;
  //         counter.update().then((value) => log('${value.success}'));
  //       });
  //     } else {
  //       log('empty list');
  //     }
  //   });
  // }
}
