// import 'dart:developer';

// // ignore: implementation_imports, unused_import
// import 'package:model_repository/src/model/models.dart' as model;
// import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

// class JobTypeRepository {
//   final int queryLimit = 1000000;

//   Future<List<model.JobType>> getJobTypeList() async {
//     log(
//       'getJobTypes() called',
//       name: 'getJobTypeList',
//     );
    
//     final QueryBuilder query = QueryBuilder<model.JobType>(model.JobType());
//     query.setLimit(queryLimit);
//     final q = await query.query();

//     if (q.results != null) {
//       final list = q.results!
//           .map((dynamic jobType) => jobType as model.JobType)
//           .toList();
//       list.sort((a, b) => a.jobTypeTitle!.compareTo(b.jobTypeTitle!));
//       return list;
//     }

//     return [];
//   }
// }
