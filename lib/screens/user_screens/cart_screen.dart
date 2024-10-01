import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.mainBgColor,
        centerTitle: true,
        title: const Text("Cart", style: TextStyle(fontFamily: "Average", fontSize: 32)),
      ),
      backgroundColor: AppConstants.mainBgColor,
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("data")
            ],
          ),
        ),
      ),
    );
  }
}