class PaymentDetails {
  String? category;
  int? amount;
  String? method;
  String? referenceId;
  DateTime? paymentDate;

  PaymentDetails({
    required this.category,
    required this.amount,
    required this.method,
    required this.referenceId,
    required this.paymentDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'amount': amount,
      'method': method,
      'referenceId': referenceId,
      'paymentDate': paymentDate?.toIso8601String(),
    };
  }

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      category: json['category'] as String,
      amount: int.tryParse(json['amount'].toString()),
      method: json['method'] as String,
      referenceId: json['referenceId'] as String,
      paymentDate: json['paymentDate'] != null ? DateTime.parse(json['paymentDate']) : null,
    );
  }
}
