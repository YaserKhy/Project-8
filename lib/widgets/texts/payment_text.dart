import 'package:flutter/material.dart';

class PaymentText extends StatelessWidget {
  const PaymentText({super.key, required this.item, required this.price});
  final String item;
  final String price;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(item, style: const TextStyle(fontSize: 20, fontFamily: "Average")),
        Text("$price SR",
            style: const TextStyle(fontSize: 20, fontFamily: "Average"))
      ],
    );
  }
}
