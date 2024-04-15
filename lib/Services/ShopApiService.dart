import 'dart:convert';
import 'package:http/http.dart' as http;

class ShopApiService {
  Future<dynamic> addShop(String shopId, String shopAddress, String shopRent) async{
    var client = http.Client();
    var apiUrl = Uri.parse("http://192.168.174.136:3001/shop/add");
    try {
      var response = await client.post(
        apiUrl,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(<String, String>{
          'shopId': shopId,
          'shopAddress': shopAddress,
          'shopRent': shopRent,
        }),
      );
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      if (responseData['status'] == 'error') {
        return {'success': false, 'message': responseData['message']};
      } else {
        return {'success': true, 'message': 'Shop added successfully'};
      }
    } else {
      return {
        'success': false,
        'message': 'Failed to add shop: ${response.statusCode}'
      };
    }
  } catch (error) {
  throw Exception('Failed to add shop: $error');
  } finally {
  client.close();
  }
}
  Future<List<String>> fetchShopIds() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.174.136:3001/shop/viewall'));
      print(response);
      if (response.statusCode == 200) {
        List<dynamic> parsedJson = jsonDecode(response.body);
        print(parsedJson);
        List<String> shopIds = parsedJson.map((shop) => shop['_id'].toString()).toList();
        return shopIds;
      } else {
        print('Failed to fetch shop IDs: Response status code: ${response.statusCode}');
        throw Exception('Failed to load shopIds');
      }
    } catch (error) {
      print('Failed to fetch shop IDs: $error');
      throw Exception('Failed to load shopIds');
    }
  }
  Future<Map<String, dynamic>> delete(String shopId) async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://192.168.174.136:3001/shop/delete");
    try {
      var response = await client.delete(
        apiUrl,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(<String, String>{
          'shopId': shopId,
        }),
      );
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          return {'success': true, 'message': 'Shop deleted successfully'};
        } else {
          return {'success': false, 'message': responseData['message']};
        }
      } else {
        return {
          'success': false,
          'message': 'Failed to delete shop: ${response.statusCode}'
        };
      }
    } catch (error) {
      throw Exception('Failed to delete shop: $error');
    } finally {
      client.close();
    }
  }
}
