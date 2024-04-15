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
import 'package:rent_collection_app/Modules/Venders/MessageVender.dart';
import 'package:rent_collection_app/Services/ShopApiService.dart';
import 'package:rent_collection_app/Services/VenderApiService.dart';

class AddPage extends StatefulWidget {

  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isDrawerOpen = false;

  final TextEditingController _mobileNumber = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _temporaryAddress = TextEditingController();
  final TextEditingController _permanentAddress = TextEditingController();
  final TextEditingController _city = TextEditingController();
  String? _selectedState;
  final TextEditingController _pinCode = TextEditingController();
  final TextEditingController _emergencyContactNumber = TextEditingController();
  final TextEditingController _shopIdController = TextEditingController();
  final TextEditingController _totalAsset = TextEditingController();
  final TextEditingController _assetList = TextEditingController();
  final TextEditingController _depositAmount = TextEditingController();
  final TextEditingController _assetRentAmount = TextEditingController();
  String? _selectedPayment;
  final TextEditingController _paymentReferenceId = TextEditingController();
  final TextEditingController _leaseStartDate = TextEditingController();
  final TextEditingController _leaseEndDate = TextEditingController();
  bool showSuccessMessage = false;

  List<String> shopIds = [];

  Future<void> fetchShopIds() async {
    try {
      shopIds = await ShopApiService().fetchShopIds();
      setState(() {});
    } catch (error) {
      print("Failed to fetch shop IDs: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to fetch shop IDs: $error"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> addVender() async {
    final String mobileNumber = _mobileNumber.text;
    final String firstName = _firstName.text;
    final String lastName = _lastName.text;
    final String temporaryAddress = _temporaryAddress.text;
    final String permanentAddress = _permanentAddress.text;
    final String city = _city.text;
    final String selectedState = _selectedState!;
    final String pinCode = _pinCode.text;
    final String emergencyContactNumber = _emergencyContactNumber.text;
    final String shopId = _shopIdController.text;
    final String totalAsset = _totalAsset.text;
    final String assetListString = _assetList.text;
    final List<String> assetList = assetListString.split(',');
    final String depositeAmount = _depositAmount.text;
    final String assetRentAmount = _assetRentAmount.text;
    final String payment = _selectedPayment!;
    final String paymentReferenceId = _paymentReferenceId.text;
    final String leaseStartDate = _leaseStartDate.text;
    final String leaseEndDate = _leaseEndDate.text;


    try {
      final response = await VenderApiService().addVender(
        mobileNumber,
        firstName,
        lastName,
        temporaryAddress,
        permanentAddress,
        city,
        selectedState,
        pinCode,
        emergencyContactNumber,
        shopId,
        totalAsset,
        assetList,
        depositeAmount,
        assetRentAmount,
        payment,
        paymentReferenceId,
        leaseStartDate,
        leaseEndDate,
      );

      if (response['success']) {
        setState(() {
          showSuccessMessage = true;
          print(response['message']);
          _mobileNumber.clear();
          _firstName.clear();
          _lastName.clear();
          _temporaryAddress.clear();
          _permanentAddress.clear();
          _city.clear();
          _selectedState = null;
          _pinCode.clear();
          _emergencyContactNumber.clear();
          _shopIdController.clear();
          _totalAsset.clear();
          _assetList.clear();
          _depositAmount.clear();
          _assetRentAmount.clear();
          _paymentReferenceId.clear();
          _leaseStartDate.clear();
          _leaseEndDate.clear();
        });
        Navigator.pop(context, shopId);
      } else {
        print(response['message']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response['message']),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print("Failed to add vendor: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to add vendor: $error"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  DateTime? _startDate;
  DateTime? _endDate;

  List<String> states = [
    "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh", "Goa",
    "Gujarat", "Haryana", "Himachal Pradesh", "Jharkhand", "Karnataka", "Kerala",
    "Madhya Pradesh", "Maharashtra", "Manipur", "Meghalaya", "Mizoram", "Nagaland",
    "Odisha", "Punjab", "Rajasthan", "Sikkim", "Tamil Nadu", "Telangana", "Tripura",
    "Uttar Pradesh", "Uttarakhand", "West Bengal"
  ];

  List<String> payment = ["Cash", "Online"];

  @override
  void initState() {
    super.initState();
    fetchShopIds();
  }

  @override
  Widget build(BuildContext context) {
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
                  onPressed: (){
                    showModalBottomSheet(
                      backgroundColor: Colors.teal.shade900,
                      context: context, builder: (BuildContext context) {
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
                                    builder: (context) => ChangePswd(),
                                  ),
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
                                    builder: (context) => Profile(),
                                  ),
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
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    );
                  }, child: Icon(Icons.account_circle, color: Colors.white, size: 30),)),
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
                  child: Text("Dashboard",style: TextStyle(fontSize: 20),),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context,index){
                  List<Map<String, dynamic>> data2 = [
                    {"leading":Icon(Icons.bar_chart,color: Colors.black,),"title": "Report", "options": ["Rent", "Deposit","Payment Report", "Shop Rent"]},
                    {"leading":Icon(Icons.person,color: Colors.black,),"title": "Vender", "options": ["Add","Message"]},
                    {"leading":Icon(Icons.area_chart,color: Colors.black,),"title": "Property", "options": ["Add Shop", "Delete Shop"]},
                    {"leading":Icon(Icons.wallet,color: Colors.black,),"title": "Payment", "options": ["Payment", "Categories"]},
                  ];
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
                        else if (newValue == "Message") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MessageVender()),
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
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              Text("Vendor Details", style: TextStyle(fontSize: 25)),
                              SizedBox(height: 20),
                              SizedBox(height: 10),
                              TextField(
                                keyboardType: TextInputType.phone,
                                controller: _mobileNumber,
                                decoration: InputDecoration(
                                  labelText: "Mobile number",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _firstName,
                                decoration: InputDecoration(
                                  labelText: "First Name",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _lastName,
                                decoration: InputDecoration(
                                  labelText: "Last Name",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _temporaryAddress,
                                decoration: InputDecoration(
                                  labelText: "Temporary Address",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _permanentAddress,
                                decoration: InputDecoration(
                                  labelText: "Permanent Address",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _city,
                                decoration: InputDecoration(
                                  labelText: "City",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.all(1),
                                child: DropdownButtonFormField<String>(
                                  value: _selectedState,
                                  items: states.map((state) {
                                    return DropdownMenuItem<String>(
                                      value: state,
                                      child: Text(state),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedState = newValue;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "State",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _pinCode,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Pin Code",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _emergencyContactNumber,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  labelText: "Emergency contact number",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text("Shop and Asset Details", style: TextStyle(fontSize: 25)),
                              SizedBox(height: 20),
                              Container(
                                padding: EdgeInsets.all(1),
                                child: DropdownButtonFormField<String>(
                                  value: _shopIdController.text,
                                  items: shopIds.map((shopId) {
                                    return DropdownMenuItem<String>(
                                      value: shopId,
                                      child: Text(shopId),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _shopIdController.text = newValue!;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Shop Id",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _totalAsset,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Total Asset",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _assetList,
                                decoration: InputDecoration(
                                  labelText: "Asset List",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _depositAmount,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Deposit Amount",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _assetRentAmount,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Asset Rent Amount",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.all(1),
                                child: DropdownButtonFormField<String>(
                                  value: _selectedPayment,
                                  items: payment.map((pay) {
                                    return DropdownMenuItem<String>(
                                      value: pay,
                                      child: Text(pay),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedPayment = newValue;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Payment Mode",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _paymentReferenceId,
                                decoration: InputDecoration(
                                  labelText: "Payment reference ID",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: "Lease Start Date",
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
                                      if (pickedDate != null && pickedDate != _startDate) {
                                        setState(() {
                                          _startDate = pickedDate;
                                          _leaseStartDate.text = '${_startDate!.year}/${_startDate!.month}/${_startDate!.day}';
                                        });
                                      }
                                    },
                                  ),
                                ),
                                readOnly: true,
                                controller: TextEditingController(
                                  text: _startDate != null
                                      ? '${_startDate!.year}/${_startDate!.month}/${_startDate!.day}'
                                      : '',
                                ),
                              ),
                              SizedBox(height: 10,),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: "Lease End Date",
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
                                      if (pickedDate != null && pickedDate != _endDate) {
                                        setState(() {
                                          _endDate = pickedDate;
                                          _leaseEndDate.text = '${_endDate!.year}/${_endDate!.month}/${_endDate!.day}';
                                        });
                                      }
                                    },
                                  ),
                                ),
                                readOnly: true,
                                controller: TextEditingController(
                                  text: _endDate != null
                                      ? '${_endDate!.year}/${_endDate!.month}/${_endDate!.day}'
                                      : '',
                                ),
                              ),
                              SizedBox(height: 15,),
                              SizedBox(
                                  height: 40,
                                  width: 100,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.teal.shade900,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5)
                                          )
                                      ),
                                      onPressed: addVender, child: Text("Submit"))),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
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
          ],
        ),
      ),
    );
  }
}
