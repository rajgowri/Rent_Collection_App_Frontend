class AddPageData {
  String? mobileNumber;
  String? firstName;
  String? lastName;
  String? temporaryAddress;
  String? permanentAddress;
  String? city;
  String? selectedState;
  String? pinCode;
  String? emergencyContactNumber;
  String? shopId;
  int? totalAsset;
  List<String>? assetList;
  double? depositAmount;
  double? assetRentAmount;
  String? selectedPayment;
  String? paymentReferenceId;
  DateTime? leaseStartDate;
  DateTime? leaseEndDate;

  AddPageData({
    this.mobileNumber,
    this.firstName,
    this.lastName,
    this.temporaryAddress,
    this.permanentAddress,
    this.city,
    this.selectedState,
    this.pinCode,
    this.emergencyContactNumber,
    this.shopId,
    this.totalAsset,
    this.assetList,
    this.depositAmount,
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
      'temporaryAddress': temporaryAddress,
      'permanentAddress': permanentAddress,
      'city': city,
      'selectedState': selectedState,
      'pinCode': pinCode,
      'emergencyContactNumber': emergencyContactNumber,
      'shopId': shopId,
      'totalAsset': totalAsset,
      'assetList': assetList,
      'depositAmount': depositAmount,
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
      temporaryAddress: json['temporaryAddress'],
      permanentAddress: json['permanentAddress'],
      city: json['city'],
      selectedState: json['selectedState'],
      pinCode: json['pinCode'],
      emergencyContactNumber: json['emergencyContactNumber'],
      shopId: json['shopId'],
      totalAsset: json['totalAsset'],
      assetList: json['assetList'] != null ? List<String>.from(json['assetList']) : null,
      depositAmount: json['depositAmount'],
      assetRentAmount: json['assetRentAmount'],
      selectedPayment: json['selectedPayment'],
      paymentReferenceId: json['paymentReferenceId'],
      leaseStartDate: json['leaseStartDate'] != null ? DateTime.parse(json['leaseStartDate']) : null,
      leaseEndDate: json['leaseEndDate'] != null ? DateTime.parse(json['leaseEndDate']) : null,
    );
  }
}
