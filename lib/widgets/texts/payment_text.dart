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
        Text(item, style: Theme.of(context).textTheme.bodyMedium,),
        Text("$price SR",style: Theme.of(context).textTheme.bodyMedium,)
      ],
    );
  }
}
