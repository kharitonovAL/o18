class Address {
  final String? city;
  final String street;
  final String houseNumber;
  final String? flatNumber;

  Address({
    required this.street,
    required this.houseNumber,
    this.flatNumber,
    this.city,
  });

  String get addressToString => 'улица $street, $houseNumber';
}
