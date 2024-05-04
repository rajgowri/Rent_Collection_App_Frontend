class AddPageData {
  String? mobileNumber;
  String? firstName;
  String? lastName;
  String? mailAddress;
  String? permanentAddress;
  String? city;
  String? selectedState;
  String? pinCode;
  String? emergencyContactNumber;
  String? shopId;
  int? totalAsset;
  double? shopRent;
  List<String>? assetList;
  double? depositeAmount;
  double? assetRentAmount;
  String? selectedPayment;
  String? paymentReferenceId;
  DateTime? leaseStartDate;
  DateTime? leaseEndDate;

  AddPageData({
    this.mobileNumber,
    this.firstName,
    this.lastName,
    this.mailAddress,
    this.permanentAddress,
    this.city,
    this.selectedState,
    this.pinCode,
    this.emergencyContactNumber,
    this.shopId,
    this.totalAsset,
    this.shopRent,
    this.assetList,
    this.depositeAmount,
    this.assetRentAmount,
    this.selectedPayment,
    this.paymentReferenceId,
    this.leaseStartDate,
    this.leaseEndDate,
  });

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'mobileNumber': mobileNumber,
      'firstName': firstName,
      'lastName': lastName,
      'mailAddress': mailAddress,
      'permanentAddress': permanentAddress,
      'city': city,
      'selectedState': selectedState,
      'pinCode': pinCode,
      'emergencyContactNumber': emergencyContactNumber,
      'shopId': shopId,
      'totalAsset': totalAsset,
      'shopRent' : shopRent,
      'assetList': assetList,
      'depositeAmount': depositeAmount,
      'assetRentAmount': assetRentAmount,
      'selectedPayment': selectedPayment,
      'paymentReferenceId': paymentReferenceId,
      'leaseStartDate': leaseStartDate?.toIso8601String(),
      'leaseEndDate': leaseEndDate?.toIso8601String(),
    };
  }

  // Method to create an object from JSON
  factory AddPageData.fromJson(Map<String, dynamic> json) {
    return AddPageData(
      mobileNumber: json['mobileNumber'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      mailAddress: json['mailAddress'],
      permanentAddress: json['permanentAddress'],
      city: json['city'],
      selectedState: json['selectedState'],
      pinCode: json['pinCode'],
      emergencyContactNumber: json['emergencyContactNumber'],
      shopId: json['shopId'],
      totalAsset: json['totalAsset'],
      shopRent : json['shopRent'],
      assetList: json['assetList'] != null ? List<String>.from(json['assetList']) : null,
      depositeAmount: json['depositeAmount'],
      assetRentAmount: json['assetRentAmount'],
      selectedPayment: json['selectedPayment'],
      paymentReferenceId: json['paymentReferenceId'],
      leaseStartDate: json['leaseStartDate'] != null ? DateTime.parse(json['leaseStartDate']) : null,
      leaseEndDate: json['leaseEndDate'] != null ? DateTime.parse(json['leaseEndDate']) : null,
    );
  }
}
