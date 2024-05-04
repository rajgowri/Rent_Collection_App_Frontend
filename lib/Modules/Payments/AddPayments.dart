import 'package:flutter/material.dart';
import 'package:rent_collection_app/Modules/HomePage.dart';
import 'package:rent_collection_app/Modules/Overview.dart';
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
import 'package:rent_collection_app/services/PaymentApiService.dart';
import 'package:intl/intl.dart';

class AddPayments extends StatefulWidget {
  const AddPayments({Key? key}) : super(key: key);

  @override
  State<AddPayments> createState() => _AddPaymentsState();
}

class _AddPaymentsState extends State<AddPayments> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isDrawerOpen = false;

  String? _selectedCategory;
  final TextEditingController _amountController = TextEditingController();
  String? _selectedMethod;
  final TextEditingController _referenceIdController = TextEditingController();
  final TextEditingController _paymentDateController = TextEditingController();
  bool showSuccessMessage = false;

  DateTime? _selectedDate;

  List<String> category = ["Deposit", "Rent"];

  List<String> method = ["Cash", "Online"];

  @override
  void initState() {
    super.initState();
    _paymentDateController.text = DateFormat.yMd().format(DateTime.now());
  }

  Future<void> addPayment() async {
    final String category = _selectedCategory!;
    final double amount = double.tryParse(_amountController.text) ?? 0.0;
    final String method = _selectedMethod!;
    final String referenceId = _referenceIdController.text;
    DateTime? selectedDate = _selectedDate;

    if (category.isEmpty || amount == 0 || method.isEmpty || referenceId.isEmpty || selectedDate == null) {
      print('Missing required fields.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all the required fields.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final result = await PaymentApiService().addPayment(
        category,
        amount,
        method,
        referenceId,
        selectedDate,
      );

      if (result['success']) {
        setState(() {
          showSuccessMessage = true;
          _selectedCategory = null;
          _amountController.clear();
          _selectedMethod = null;
          _referenceIdController.clear();
          _paymentDateController.clear();
          _selectedDate = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add payment. Please try again later.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print('Error adding payment: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again later.'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        showSuccessMessage = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data2 = [
      {"leading":Icon(Icons.bar_chart,color: Colors.black,),"title": "Report", "options": ["Rent", "Deposit","Payment Report", "Asset Rent", "Shop Rent"]},
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
              setState(() {
                _isDrawerOpen = !_isDrawerOpen;
                if (_isDrawerOpen) {
                  _scaffoldKey.currentState!.openDrawer();
                } else {
                  _scaffoldKey.currentState!.openEndDrawer();
                }
              });
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
                              leading: Icon(Icons.settings, color: Colors.teal.shade200),
                              title: Text("Change Password", style: TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ChangePswd()),
                                );
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.person, color: Colors.teal.shade200),
                              title: Text("My Profile", style: TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Profile()),
                                );
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.logout, color: Colors.teal.shade200),
                              title: Text("Logout", style: TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomePage()),
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
                    foregroundColor: Colors.black,
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
                  child: Text(
                    "Dashboard",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: data2.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: data2[index]["leading"] as Widget?,
                    title: Text(data2[index]["title"] as String),
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
                // Shop Keepers Details
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(20), // Add margin to separate sections
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text("Add Payment", style: TextStyle(fontSize: 25)),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        items: category.map((state) {
                          return DropdownMenuItem<String>(
                            value: state,
                            child: Text(state),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategory = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Select Category",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Amount",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _selectedMethod,
                        items: method.map((state) {
                          return DropdownMenuItem<String>(
                            value: state,
                            child: Text(state),
                          );
                        }).toList(),
                         onChanged: (newValue) {
                          setState(() {
                            _selectedMethod = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Select Method",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _referenceIdController,
                        decoration: InputDecoration(
                          labelText: "Reference ID",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Payment Date",
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  _selectedDate = pickedDate;
                                  _paymentDateController.text = DateFormat('yyyy/MM/dd').format(pickedDate); // Use the desired format
                                });
                              }
                            },
                          ),
                        ),
                        readOnly: true,
                        controller: _paymentDateController,
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              width: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.teal.shade900,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: addPayment,
                                child: Text("Submit"),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              width: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.teal.shade900,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Back"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
