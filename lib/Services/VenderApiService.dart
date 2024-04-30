import 'dart:convert';
import 'package:http/http.dart' as http;

class VenderApiService {
  static final _client = http.Client();

  Future<Map<String, dynamic>> addVender(
      String mobileNumber,
      String firstName,
      String lastName,
      String temporaryAddress,
      String permanentAddress,
      String city,
      String selectedState,
      String pinCode,
      String emergencyContactNumber,
      String shopId,
      String totalAsset,
      List<String> assetList,
      String shopRent,
      String depositeAmount,
      String assetRentAmount,
      String selectedPayment,
      String paymentReferenceId,
      String leaseStartDate,
      String leaseEndDate) async {
    try {
      var apiUrl = Uri.parse("http://192.168.88.136:3001/vendor/add");
      var response = await _client.post(
        apiUrl,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(<String, dynamic>{
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
          "assetList": assetList,
          "shopRent" : shopRent,
          "depositeAmount": depositeAmount,
          "assetRentAmount": assetRentAmount,
          "selectedPayment": selectedPayment,
          "paymentReferenceId": paymentReferenceId,
          "leaseStartDate": leaseStartDate,
          "leaseEndDate": leaseEndDate
        }),
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData["status"] == "success" &&
            responseData["message"] == "successfully added vendor") {
          return {
            'success': true,
            'message': 'Vendor added successfully'
          };
        } else {
          throw Exception(
              "Failed to add vendor: ${responseData['message']}");
        }
      } else {
        throw Exception(
            "Failed to add vendor: ${response.reasonPhrase}");
      }
    } catch (error) {
      throw Exception("Failed to add vendor: $error");
    }
  }
}