import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/models/order_model.dart';

class OrderCard extends StatelessWidget {
  const OrderCard(
      {super.key,
      required this.order,
      this.onTap});
  final OrderModel order;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> itemAndPrice = {};
    for (var list in GetIt.I.get<ItemLayer>().prevCarts) {
      for (var map in list) {
        if(map['order_id']==order.orderId) {
          itemAndPrice[map['item_name']] = map['item_price'];
        }
      }
    }
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        margin: const EdgeInsets.symmetric(vertical: 16),
        width: context.getWidth(),
        height: context.getWidth(divideBy: 3.4),
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
            Row(
              children: [
                const Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  "Order No. ",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Average",
                      color: AppConstants.mainRed),
                ),
                Text(
                  '#${order.orderId.toString()}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 20, fontFamily: "Average"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${order.orderDate?.split('T').first} | ${order.orderDate?.split('T')[1].split('.').first}' ?? "undefined",
                  style: const TextStyle(
                      color: AppConstants.subTextColor,
                      fontSize: 18,
                      fontFamily: "Average"),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppConstants.mainlightBlue.withOpacity(0.2),
                      border: Border.all(color: AppConstants.mainlightBlue)),
                  child: Text(order.status ?? 'why',
                      style: const TextStyle(
                          color: AppConstants.mainlightBlue,
                          fontSize: 18,
                          fontFamily: "Average")),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
