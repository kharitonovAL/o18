/// This class encapsulates data which was parsed from [*.xlsx] file.
/// Need to update info about flats, accounts and owners in database.
class HouseTableData {
  String accountNumber;
  String flatNumber;
  String ownerName;
  double flatSquare;
  int numberOfResidents;
  double debt;

  HouseTableData({
    required this.accountNumber,
    required this.flatNumber,
    required this.ownerName,
    required this.flatSquare,
    required this.numberOfResidents,
    required this.debt,
  });
}
