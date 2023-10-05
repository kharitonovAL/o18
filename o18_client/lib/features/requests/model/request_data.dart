import 'package:model_repository/model_repository.dart';

class RequestData {
  final UserRequest? userRequest;
  final String? operatorName;
  final int requestNumber;
  final List<House> houseList;
  final Address? address;
  final List<Account> accountList;
  final Account? account;
  final Owner? owner;
  final List<Owner>? ownerList;
  final Partner? partner;
  final List<Partner>? partnerList;
  final Staff? master;
  final List<Staff>? masterList;
  final Staff? staff;
  final List<Staff>? staffList;

  RequestData({
    required this.requestNumber,
    required this.houseList,
    required this.accountList,
    this.operatorName,
    this.userRequest,
    this.account,
    this.address,
    this.owner,
    this.ownerList,
    this.partner,
    this.partnerList,
    this.master,
    this.masterList,
    this.staff,
    this.staffList,
  });
}
