import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rent_collection_app/Models/ChangePswdModel.dart';

class UserApiService {
  Future<dynamic> registerUser(String firstName, String lastName,
      String emailAddress, String mobileNumber, String password) async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://192.168.88.136:3001/user/signup");
    try {
      var response = await client.post(
        apiUrl,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(<String, String>{
          "firstName": firstName,
          "lastName": lastName,
          "emailAddress": emailAddress,
          "mobileNumber": mobileNumber,
          "password": password
        }),
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData["status"] == "success" && responseData["message"] == "successfully registered user") {
          return responseData; // Return the response data
        } else {
          throw Exception("Registration failed: ${responseData['message']}");
        }
      } else if (response.statusCode == 400) {
        var responseData = json.decode(response.body);
        if (responseData["status"] == "error" && responseData["message"] == "user already exists") {
          throw Exception("User already exists"); // Handle user already exists scenario
        } else {
          throw Exception("Bad request: ${response.reasonPhrase}");
        }
      } else {
        throw Exception("Failed to register user. Server responded with status code: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Failed to register user: $error");
    } finally {
      client.close();
    }
  }


  Future<dynamic> loginUser(String emailAddress, String password) async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://192.168.88.136:3001/user/signin");
    try {
      var response = await client.post(
        apiUrl,
        headers: <String, String>{"Content-Type": "application/json; charset=UTF-8"},
        body: jsonEncode(<String, String>{
          "emailAddress": emailAddress,
          "password": password
        }),
      );
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData["status"] == "success" && responseData["message"] == "authentification successfull") {
          return responseData; // Return the response data
        } else {
          throw Exception("Login failed: ${responseData['message']}");
        }
      } else {
        throw Exception("Failed to login. Server responded with status code: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Failed to login: $error");
    } finally {
      client.close(); // Close the client connection
    }
  }

  Future<dynamic>SendUsername(String firstName)async
  {
    var client=http.Client();
    var apiurl=Uri.parse("");
    var response=await client.post(apiurl,
        headers: <String,String>{
          "Content-Type":"application/json; charset=UTF-8"

        },
        body: jsonEncode(<String,String>
        {
          "firstName":firstName
        })
    );
    if(response.statusCode==200)
    {
      return json.decode(response.body);
    }
    else
    {
      throw Exception("Failed to send data");
    }
  }
  Future<dynamic> changePswd(String oldPassword, String newPassword, String emailAddress) async {
    var client = http.Client();
    var apiUrl = Uri.parse("");
    try {
      var response = await client.post(
        apiUrl,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(<String, String>{
          "emailAddress": emailAddress,
          "oldPassword": oldPassword,
          "newPassword": newPassword
        }),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception("Failed to send data");
      }
    } catch (error) {
      throw Exception("Error: $error");
    } finally {
      client.close();
    }
  }
}
