// To parse this JSON data, do
//
//     final search = searchFromJson(jsonString);

import 'dart:convert';

Search searchFromJson(String str) => Search.fromJson(json.decode(str));

String searchToJson(Search data) => json.encode(data.toJson());

class Search {
  String status;
  Data data;

  Search({
    required this.status,
    required this.data,
  });

  factory Search.fromJson(Map<String, dynamic> json) => Search(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  String id;
  String mobileNumber;
  String firstName;
  String lastName;
  String temporaryAddress;
  String permanentAddress;
  String city;
  String selectedState;
  String pinCode;
  String emergencyContactNumber;
  String shopId;
  int totalAsset;
  List<String> assetList;
  int depositeAmount;
  int assetRentAmount;
  String selectedPayment;
  int paymentReferenceId;
  DateTime leaseStartDate;
  DateTime leaseEndDate;
  int v;

  Data({
    required this.id,
    required this.mobileNumber,
    required this.firstName,
    required this.lastName,
    required this.temporaryAddress,
    required this.permanentAddress,
    required this.city,
    required this.selectedState,
    required this.pinCode,
    required this.emergencyContactNumber,
    required this.shopId,
    required this.totalAsset,
    required this.assetList,
    required this.depositeAmount,
    required this.assetRentAmount,
    required this.selectedPayment,
    required this.paymentReferenceId,
    required this.leaseStartDate,
    required this.leaseEndDate,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    mobileNumber: json["mobileNumber"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    temporaryAddress: json["temporaryAddress"],
    permanentAddress: json["permanentAddress"],
    city: json["city"],
    selectedState: json["selectedState"],
    pinCode: json["pinCode"],
    emergencyContactNumber: json["emergencyContactNumber"],
    shopId: json["shopId"],
    totalAsset: json["totalAsset"],
    assetList: List<String>.from(json["assetList"].map((x) => x)),
    depositeAmount: json["depositeAmount"],
    assetRentAmount: json["assetRentAmount"],
    selectedPayment: json["selectedPayment"],
    paymentReferenceId: json["paymentReferenceId"],
    leaseStartDate: DateTime.parse(json["leaseStartDate"]),
    leaseEndDate: DateTime.parse(json["leaseEndDate"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "mobileNumber": mobileNumber,
    "firstName": firstName,
    "lastName": lastName,
    "temporaryAddress": temporaryAddress,
    "permanentAddress": permanentAddress,
    "city": city,
    "selectedState": selectedState,
    "pinCode": pinCode,
    "emergencyContactNumber": emergencyContactNumber,
    "shopId": shopId,
    "totalAsset": totalAsset,
    "assetList": List<dynamic>.from(assetList.map((x) => x)),
    "depositeAmount": depositeAmount,
    "assetRentAmount": assetRentAmount,
    "selectedPayment": selectedPayment,
    "paymentReferenceId": paymentReferenceId,
    "leaseStartDate": leaseStartDate.toIso8601String(),
    "leaseEndDate": leaseEndDate.toIso8601String(),
    "__v": v,
  };
}
