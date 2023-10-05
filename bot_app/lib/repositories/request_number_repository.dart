import 'package:bot_app/models/request_number.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class RequestNumberRepository {
  RequestNumberRepository();

  static const int queryLimit = 1000000;

  Future<int> lastRequestNumber() async {
    print('... getRequestNumbers() called');
    final QueryBuilder query = QueryBuilder<RequestNumber>(RequestNumber());
    query.setLimit(queryLimit);
    final q = await query.query();

    final qResults = q.results;

    if (qResults != null) {
      final list =
          qResults.map((dynamic reqNum) => reqNum as RequestNumber).toList();
      print(list.last.requestNumber);
      return list.last.requestNumber!;
    }
    throw 'getLastRequestNumber throw';
  }

  Future<bool> incrementRequestNumbers() async {
    print('... incrementRequestNumbers() called');
    var rn = RequestNumber();
    rn.requestNumber = await lastRequestNumber() + 1;
    final response = await rn.save();
    return response.success;
  }
}
