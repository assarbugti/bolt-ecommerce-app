class AddressModel {
  final String addressName;
  final String addressLane;
  final String addressCity;
  final String addressPostalCode;
  final String addressPhoneNumber;
  final String addressId;

  AddressModel({
    required this.addressCity,
    required this.addressLane,
    required this.addressName,
    required this.addressPhoneNumber,
    required this.addressId,
    required this.addressPostalCode,
  });

  factory AddressModel.fromJson(json) => AddressModel(
        addressCity: json["addressCity"],
        addressLane: json["addressLane"],
        addressName: json["addressName"],
        addressPhoneNumber: json["addressPhoneNumber"],
        addressPostalCode: json["addressPostalCode"],
        addressId: json["addressId"],
      );
}
