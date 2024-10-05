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
        Text(title, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppConstants.mainRed)),
        Expanded(child: Text(content, softWrap: true, overflow: TextOverflow.visible,style: Theme.of(context).textTheme.bodyMedium)),
      ],
    );
  }
}