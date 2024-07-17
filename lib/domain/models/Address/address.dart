class Address {
  final String district, street, postalCode;

  Address(
      {required this.district, required this.street, required this.postalCode});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      district: json['address']['district'] ?? '',
      street: json['address']['street'] ?? '',
      postalCode: json['address']['postalCode'] ?? '',
    );
  }
}
