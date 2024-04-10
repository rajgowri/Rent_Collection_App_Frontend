class PaymentDetails {
  final String category;
  final double amount;
  final String method;
  final String referenceId;
  final DateTime paymentDate;

  PaymentDetails({
    required this.category,
    required this.amount,
    required this.method,
    required this.referenceId,
    required this.paymentDate,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      category: json['category'] as String,
      amount: json['amount'] as double,
      method: json['method'] as String,
      referenceId: json['referenceId'] as String,
      paymentDate: DateTime.parse(json['paymentDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'amount': amount,
      'method': method,
      'referenceId': referenceId,
      'paymentDate': paymentDate.toIso8601String(),
    };
  }
}
