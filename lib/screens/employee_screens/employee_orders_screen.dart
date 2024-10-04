import 'package:flutter/material.dart';

class EmployeeOrdersScreen  extends StatelessWidget {
  const EmployeeOrdersScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Employee Orders page")],
        ),
      ),
    );
  }
}
