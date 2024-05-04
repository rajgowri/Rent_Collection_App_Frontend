import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rent_collection_app/Modules/HomePage.dart';
import 'package:rent_collection_app/Modules/Payments/Categories.dart';
import 'package:rent_collection_app/Modules/Payments/Payments.dart';
import 'package:rent_collection_app/Modules/Profile/ChangePassword.dart';
import 'package:rent_collection_app/Modules/Profile/Profile.dart';
import 'package:rent_collection_app/Modules/Property/AddShop.dart';
import 'package:rent_collection_app/Modules/Property/DeleteShop.dart';
import 'package:rent_collection_app/Modules/Reports/Deposit.dart';
import 'package:rent_collection_app/Modules/Reports/PaymentReport.dart';
import 'package:rent_collection_app/Modules/Reports/Rent.dart';
import 'package:rent_collection_app/Modules/Reports/ShopReport.dart';
import 'package:rent_collection_app/Modules/Venders/AddVender.dart';

class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isDrawerOpen = false;
  String totalAssets = '0';
  String totalRent = '0';
  String totalDeposite = '0';
  String totalIncome = '0';
  String totalShops = '0';
  String totalVenders = '0';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      // Fetch total assets
      final assetsResponse = await http.post(
        Uri.parse("http://192.168.88.136:3001/vendor/total"),
      );

      if (assetsResponse.statusCode == 200) {
        Map<String, dynamic> assetsData = json.decode(assetsResponse.body);
        setState(() {
          totalAssets = assetsData['total'].toString();
        });
      } else {
        throw Exception('Failed to load data');
      }

      final rentResponse = await http.post(
        Uri.parse("http://192.168.88.136:3001/vendor/totalRent"),
      );

      if (rentResponse.statusCode == 200) {
        Map<String, dynamic> rentData = json.decode(rentResponse.body);
        setState(() {
          totalRent = rentData['total'].toString();
        });
      } else {
        throw Exception('Failed to load data');
      }

      // Fetch total deposit
      final depositResponse = await http.post(
        Uri.parse("http://192.168.88.136:3001/vendor/totalDeposite"),
      );

      if (depositResponse.statusCode == 200) {
        Map<String, dynamic> depositData = json.decode(depositResponse.body);
        setState(() {
          totalDeposite = depositData['total'].toString();
          // Calculate total income
          totalIncome =
              (int.parse(totalRent) + int.parse(totalDeposite)).toString();
        });
      } else {
        throw Exception('Failed to load data');
      }

      final shopsResponse = await http.post(
        Uri.parse("http://192.168.88.136:3001/shop/number"),
      );

      if (shopsResponse.statusCode == 200) {
        Map<String, dynamic> shopsData = json.decode(shopsResponse.body);
        setState(() {
          totalShops = shopsData['totalShops'].toString(); // Update totalShops with fetched value
        });
      } else {
        throw Exception('Failed to load data');
      }

      final venderResponse = await http.post(
        Uri.parse("http://192.168.88.136:3001/vendor/number"),
      );

      if (venderResponse.statusCode == 200) {
        Map<String, dynamic> venderData = json.decode(venderResponse.body);
        setState(() {
          totalVenders = venderData['totalVendors'].toString();
        });
      } else {
        throw Exception('Failed to load data');
      }

    } catch (error) {
      print(error);
    }
  }


  @override
  Widget build(BuildContext context) {
          List<Map<String, dynamic>> data = [
            {
              "title": totalVenders,
              "subtitle": "Vender",
              "trailing": Icon(Icons.person, color: Colors.teal, size: 35)
            },
            {
              "title": totalShops,
              "subtitle": "Shops",
              "trailing": Icon(Icons.home, color: Colors.teal, size: 35)
            },
            {
              "title": totalAssets,
              "subtitle": "Assets",
              "trailing": Icon(
                  Icons.table_restaurant_rounded, color: Colors.teal, size: 35)
            },
          ];

          List<Map<String, dynamic>> data1 = [
            {
              "leading": CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.currency_rupee, color: Colors.white)),
              "title": "$totalDeposite Rs",
              "subtitle": "Total Deposit"
            },
            {
              "leading": CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.currency_rupee, color: Colors.white,)),
              "title": "$totalIncome Rs",
              "subtitle": "Total Income"
            },
            {
              "leading": CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.currency_rupee, color: Colors.white)),
              "title": "$totalRent Rs",
              "subtitle": "Total Rent"
            },
          ];

          List<Map<String, dynamic>> data2 = [
            {
              "leading": Icon(Icons.bar_chart, color: Colors.black,),
              "title": "Report",
              "options": ["Rent", "Deposit", "Payment Report", "Shop Rent"]
            },
            {
              "leading": Icon(Icons.person, color: Colors.black,),
              "title": "Vender",
              "options": ["Add"]
            },
            {
              "leading": Icon(Icons.area_chart, color: Colors.black,),
              "title": "Property",
              "options": ["Add Shop", "Delete Shop"]
            },
            {
              "leading": Icon(Icons.wallet, color: Colors.black,),
              "title": "Payment",
              "options": ["Payment", "Categories"]
            },
          ];

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Colors.grey.shade200,
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
                            backgroundColor: Colors.teal.shade900
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.teal.shade900,
                            context: context, builder: (BuildContext context) {
                            return Container(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppBar(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Adjust the value as needed
                                    ),
                                    leading: Icon(Icons.account_circle, size: 40,),
                                    title: Text(
                                      "Robert", style: TextStyle(fontSize: 20),),
                                  ),
                                  SizedBox(height: 20),
                                  ListTile(
                                    leading: (Icon(Icons.settings,
                                      color: Colors.teal.shade200,)),
                                    title: Text("Change Password",
                                      style: TextStyle(color: Colors.white),),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ChangePswd())
                                      );
                                    },
                                  ), ListTile(
                                    leading: (Icon(
                                      Icons.person, color: Colors.teal.shade200,)),
                                    title: Text("My Profile",
                                      style: TextStyle(color: Colors.white),),
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
                                    leading: (Icon(
                                      Icons.logout, color: Colors.teal.shade200,)),
                                    title: Text("Logout",
                                      style: TextStyle(color: Colors.white),),
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
                        child: Icon(
                            Icons.account_circle, color: Colors.white, size: 30),)),
                  SizedBox(width: 10,)
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
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.teal.shade900,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)
                            )
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Overview()),
                          );
                        },
                        child: Text(
                          "Dashboard", style: TextStyle(fontSize: 20, color: Colors
                            .white),),
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
                            items: (data2[index]["options"] as List<String>).map((
                                String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue == "Rent") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RentReportPage()),
                                );
                              }
                              else if (newValue == "Deposit") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DepositReportPage()),
                                );
                              }
                              else if (newValue == "Payment Report") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaymentReportPage()),
                                );
                              }
                              else if (newValue == "Shop Rent") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShopReportPage()),
                                );
                              }
                              else if (newValue == "Add") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddPage()),
                                );
                              }
                              else if (newValue == "Add Shop") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddShopsPage()),
                                );
                              }
                              else if (newValue == "Delete Shop") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DeleteShopsPage()),
                                );
                              }
                              else if (newValue == "Payment") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaymentsPage()),
                                );
                              }
                              else if (newValue == "Categories") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CategoriesPage()),
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
              body: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Overview", style: TextStyle(fontSize: 25),),
                    SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white,
                            child: ListTile(
                              title: Text(data[index]["title"],
                                  style: TextStyle(fontSize: 25)),
                              subtitle: Text(data[index]["subtitle"],
                                  style: TextStyle(fontSize: 17)),
                              trailing: data[index]["trailing"],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 30,),
                    Text("Overview", style: TextStyle(fontSize: 25),),
                    Text("Last month overall report",
                      style: TextStyle(fontSize: 15),),
                    SizedBox(height: 30),
                    Expanded(
                      child:ListView.builder(
                      itemCount: data1.length,
                      itemBuilder: (context, index)
                      {
                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            leading: data1[index]["leading"],
                            title: Text(data1[index]["title"],
                                style: TextStyle(fontSize: 23)),
                            subtitle: Text(data1[index]["subtitle"],
                                style: TextStyle(fontSize: 15)),
                          ),
                        );
                      }
                      ),
                    ),
                ],
                ),
              ),
            ),
          );
  }
}

