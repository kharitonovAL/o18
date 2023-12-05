// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:developer';

// ignore: implementation_imports, unused_import
import 'package:model_repository/src/model/models.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class StaffRepository {
  final int queryLimit = 1000000;

  Future<List<Staff>> getStaffList() async {
    log(
      'getPartnerStaff() called',
      name: 'PartnerRepository: getPartnerStaffList',
    );

    final QueryBuilder query = QueryBuilder<Staff>(Staff());
    query.setLimit(queryLimit);
    final q = await query.query();

    if (q.results != null) {
      final list = q.results!
          .map(
            (dynamic s) => s as Staff,
          )
          .toList()
        ..sort((a, b) => a.name!.compareTo(b.name!));
      return list;
    }

    return [];
  }

  Future<String> getStaffPhoneNumber({
    required String partner,
    required String staffName,
  }) async {
    log(
      'getStaffPhoneNumber() called',
      name: 'PartnerRepository: getStaffPhoneNumber',
    );

    final QueryBuilder query = QueryBuilder<Staff>(Staff());
    query.setLimit(queryLimit);
    final q = await query.query();
    final list = q.results == null ? <Staff>[] : q.results!.map((dynamic staff) => staff as Staff).toList();

    var phoneNumber = '';

    list.forEach((staff) {
      if (staff.partnerId == partner && staff.name == staffName) {
        phoneNumber = staff.phoneNumber!;
      }
    });

    return phoneNumber;
  }

  Future<String?> getStaffToken({
    required String staffName,
    required String partnerId,
  }) async {
    log(
      'getStaffToken() called',
      name: 'PartnerRepository: getStaffToken',
    );

    final list = await getStaffList();
    final staff = list.firstWhere(
      (staff) => staff.name == staffName && staff.partnerId == partnerId,
    );
    return staff.deviceToken;
  }
}
