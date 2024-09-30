import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/extensions/screen_size.dart';

class OrderCard extends StatelessWidget {
  const OrderCard(
      {super.key,
      required this.order,
      required this.orderDate,
      required this.status});
  final String order;
  final String orderDate;
  final String status;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: context.getWidth(divideBy: 1.1),
      height: context.getWidth(divideBy: 3.6),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 4), blurRadius: 4)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            "Order: $order ",
            style: const TextStyle(fontSize: 20, fontFamily: "Average"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderDate,
                style: const TextStyle(
                    color: AppConstants.subTextColor,
                    fontSize: 18,
                    fontFamily: "Average"),
              ),
              Text(status,
                  style: const TextStyle(
                      color: AppConstants.mainlightBlue,
                      fontSize: 18,
                      fontFamily: "Average"))
            ],
          )
        ],
      ),
    );
  }
}
