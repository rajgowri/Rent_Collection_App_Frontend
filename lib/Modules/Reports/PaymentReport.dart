import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rent_collection_app/Modules/HomePage.dart';
import 'package:rent_collection_app/Modules/Overview.dart';
import 'package:rent_collection_app/Modules/Payments/Categories.dart';
import 'package:rent_collection_app/Modules/Payments/Payments.dart';
import 'package:rent_collection_app/Modules/Profile/ChangePassword.dart';
import 'package:rent_collection_app/Modules/Profile/Profile.dart';
import 'package:rent_collection_app/Modules/Property/AddShop.dart';
import 'package:rent_collection_app/Modules/Property/DeleteShop.dart';
import 'package:rent_collection_app/Modules/Reports/Deposit.dart';
import 'package:rent_collection_app/Modules/Reports/Rent.dart';
import 'package:rent_collection_app/Modules/Reports/ShopReport.dart';
import 'package:rent_collection_app/Modules/Venders/AddVender.dart';

class PaymentReportPage extends StatefulWidget {
  const PaymentReportPage({Key? key}) : super(key: key);

  @override
  State<PaymentReportPage> createState() => _PaymentReportPageState();
}

class _PaymentReportPageState extends State<PaymentReportPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isDrawerOpen = false;

  String? selectedCategory;
  List<String> category = ["Deposit", "Rent"];

  String? selectedMethod;
  List<String> method = ["Cash", "Online"];

  String? searchQuery;
  String? note;

  TextEditingController referenceController = new TextEditingController();
  TextEditingController categoryController = new TextEditingController();
  TextEditingController methodController = new TextEditingController();
  List<dynamic> _searchResult = [];

  Future<void> _searchPayment(String? category, String? method, String? referenceId) async {
    try {
      final Map<String, dynamic> requestBody = {};

      if (category != null) {
        requestBody['category'] = category;
      }
      if (method != null) {
        requestBody['method'] = method;
      }
      if (referenceId != null) {
        requestBody['referenceId'] = referenceId;
      }

      final response = await http.post(
        Uri.parse('http://192.168.88.136:3001/payment/search'),
        body: json.encode(requestBody),
        headers: {
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          if (jsonResponse['data'] != null) {
            if (jsonResponse['data'] is List) {
              _searchResult = jsonResponse['data'];
            } else {
              _searchResult = [jsonResponse['data']];
            }
          } else {
            _searchResult = [];
          }
        });
      } else {
        throw Exception('Failed to load search results');
      }
    } catch (e) {
      print('Error: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to search payments. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    referenceController.clear();
    categoryController.clear();
    methodController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data2 = [
      {"leading":Icon(Icons.bar_chart,color: Colors.black,),"title": "Report", "options": ["Rent", "Deposit","Payment Report", "Shop Rent"]},
      {"leading":Icon(Icons.person,color: Colors.black,),"title": "Vender", "options": ["Add"]},
      {"leading":Icon(Icons.area_chart,color: Colors.black,),"title": "Property", "options": ["Add Shop", "Delete Shop"]},
      {"leading":Icon(Icons.wallet,color: Colors.black,),"title": "Payment", "options": ["Payment", "Categories"]},
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade300,
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.teal.shade900,
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.white, size: 30),
            onPressed: () {
              if (_isDrawerOpen) {
                _scaffoldKey.currentState!.openEndDrawer();
                _isDrawerOpen = false;
              } else {
                _scaffoldKey.currentState!.openDrawer();
                _isDrawerOpen = true;
              }
            },
          ),
          actions: [
            SizedBox(
              width: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal.shade900,
                ),
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.teal.shade900,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppBar(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              leading: Icon(Icons.account_circle, size: 40),
                              title: Text("Robert", style: TextStyle(fontSize: 20)),
                            ),
                            SizedBox(height: 20),
                            ListTile(
                              leading: (Icon(Icons.settings,color: Colors.teal.shade200,)),
                              title: Text("Change Password",style: TextStyle(color: Colors.white),),
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChangePswd())
                                );
                              },
                            ), ListTile(
                              leading: (Icon(Icons.person,color: Colors.teal.shade200,)),
                              title: Text("My Profile",style: TextStyle(color: Colors.white),),
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile())
                                );
                              },
                            ),
                            ListTile(
                              leading: (Icon(Icons.logout,color: Colors.teal.shade200,)),
                              title: Text("Logout",style: TextStyle(color: Colors.white),),
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage())
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Icon(Icons.account_circle, color: Colors.white, size: 30),
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 70),
              SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.teal.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Overview()),
                    );
                  },
                  child: Text("Dashboard", style: TextStyle(fontSize: 20)),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: data2.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: data2[index]["leading"],
                    title: Text(data2[index]["title"]),
                    trailing: DropdownButton<String>(
                      elevation: 0,
                      underline: Container(),
                      iconEnabledColor: Colors.black,
                      items: (data2[index]["options"] as List<String>).map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue == "Rent") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RentReportPage()),
                          );
                        }
                        else if (newValue == "Deposit") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DepositReportPage()),
                          );
                        }
                        else if (newValue == "Payment Report") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PaymentReportPage()),
                          );
                        }
                        else if (newValue == "Shop Rent") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ShopReportPage()),
                          );
                        }
                        else if (newValue == "Add") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddPage()),
                          );
                        }
                        else if (newValue == "Add Shop") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddShopsPage()),
                          );
                        }
                        else if (newValue == "Delete Shop") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DeleteShopsPage()),
                          );
                        }
                        else if (newValue == "Payment") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PaymentsPage()),
                          );
                        }
                        else if (newValue == "Categories") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CategoriesPage()),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text("Search", style: TextStyle(fontSize: 25)),
                      SizedBox(height: 20),
                      TextField(
                        controller: referenceController,
                        decoration: InputDecoration(
                            labelText: "Search by Reference Id",
                            border: OutlineInputBorder()
                        ),
                      ),
                      SizedBox(height: 20,),
                      DropdownButtonFormField<String>(
                        value: selectedCategory,
                        items: category.map((state) {
                          return DropdownMenuItem<String>(
                            value: state,
                            child: Text(state),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedCategory = newValue;
                            if (newValue == "Others") {
                              searchQuery = null;
                            }
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Select Category",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      if (selectedCategory == "Others") ...[
                        SizedBox(height: 10),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Search",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: selectedMethod,
                        items: method.map((m) {
                          return DropdownMenuItem<String>(
                            value: m,
                            child: Text(m),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedMethod = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Select Method",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              width: 100,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.teal.shade900,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () async{
                                  await _searchPayment(selectedCategory, selectedMethod, referenceController.text);
                                },
                                child: Text("Search"),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20), // Add some spacing between sections
                SizedBox(
                  height: 300, // Set a fixed height to limit the height of the second ListView
                  child: ListView.builder(
                    itemCount: _searchResult.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                 "Category: ${_searchResult[index]['category'] ?? ''}",
                                 style: TextStyle(fontWeight: FontWeight.bold),
                               ),
                               Text(
                                 "Method: ${_searchResult[index]['method'] ?? ''}",
                                 style: TextStyle(fontWeight: FontWeight.bold),
                               ),
                               Text(
                                 "Reference Id: ${_searchResult[index]['referenceId'] ?? ''}",
                                 style: TextStyle(fontWeight: FontWeight.bold),
                               ),
                               Text(
                                 "Payment Date: ${_searchResult[index]['paymentDate'] ?? ''}",
                                 style: TextStyle(fontWeight: FontWeight.bold),
                               ),
                               Text(
                                 "Amount: ${_searchResult[index]['amount'] ?? ''}",
                                 style: TextStyle(fontWeight: FontWeight.bold),
                               ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
