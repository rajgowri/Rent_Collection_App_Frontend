import 'package:flutter/material.dart';
import 'package:rent_collection_app/Modules/HomePage.dart';

void main() {
  runApp(Rent_Collection());
}

class Rent_Collection extends StatelessWidget {
  const Rent_Collection({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}