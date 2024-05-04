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

class Data{
  String id;
  String category;
  int amount;
  String method;
  int referenceId;
  DateTime paymentDate;
  int v;

  Data({
    required this.id,
    required this.category,
    required this.amount,
    required this.method,
    required this.referenceId,
    required this.paymentDate,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    category: json["category"],
    amount: json["amount"],
    method: json["method"],
    referenceId: json["referenceId"],
    paymentDate: DateTime.parse(json["paymentDate"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "category": category,
    "amount": amount,
    "method": method,
    "referenceId": referenceId,
    "paymentDate": paymentDate.toIso8601String(),
    "__v": v,
  };
}
