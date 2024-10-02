import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';

class OrderText extends StatelessWidget {
  const OrderText({super.key, required this.title, required this.content});
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 20, fontFamily: "Average", color: AppConstants.mainRed),
        ),
        Expanded(
          child: Text(
            overflow: TextOverflow.visible,
            softWrap: true,
            content,
            style: const TextStyle(fontSize: 20, fontFamily: "Average"),
          ),
        ),
      ],
    );
  }
}
