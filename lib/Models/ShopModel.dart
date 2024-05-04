

import 'dart:convert';

Shop shopFromJson(String str) => Shop.fromJson(json.decode(str));

String shopToJson(Shop data) => json.encode(data.toJson());

class Shop {
  String status;
  List<Datum> data;

  Shop({
    required this.status,
    required this.data,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String shopId;
  int v;

  Datum({
    required this.id,
    required this.shopId,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    shopId: json["shopId"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "shopId": shopId,
    "__v": v,
  };
}
