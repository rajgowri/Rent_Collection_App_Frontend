class Shop {
  final String shopId;
  final String shopAddress;
  final String shopRent;

  Shop({
    required this.shopId,
    required this.shopAddress,
    required this.shopRent,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      shopId: json['shopId'],
      shopAddress: json['shopAddress'],
      shopRent: json['shopRent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shopId': shopId,
      'shopAddress': shopAddress,
      'shopRent': shopRent,
    };
  }
}
