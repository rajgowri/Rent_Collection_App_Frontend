import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentApiService {
  Future<dynamic> addPayment(
      String category,
      double amount,
      String method,
      String referenceId,
      DateTime selectedDate) async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://192.168.88.136:3001/payment/add");
    try {
      var response = await client.post(
        apiUrl,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(<String, dynamic>{
          "category": category,
          "amount": amount,
          "method": method,
          "referenceId": referenceId,
          "paymentDate": selectedDate.toIso8601String(),
        }),
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData["status"] == "success" &&
            responseData["message"] == "successfully added payment") {
          return {
            'success': true,
            'message': 'Payment added successfully'
          };
        } else {
          throw Exception("Failed to add payment: ${responseData['message']}");
        }
      } else {
        throw Exception("Failed to add payment: ${response.reasonPhrase}");
      }
    } catch (error) {
      throw Exception("Failed to add payment: $error");
    } finally {
      client.close();
    }
  }
}