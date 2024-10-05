import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/models/order_model.dart';

class EmployeeOrderCard extends StatelessWidget {
  final OrderModel order;
  final Function()? onTap;
  void Function()? changeStatus;
  EmployeeOrderCard(
      {super.key, required this.order, this.onTap, this.changeStatus});
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> itemAndPrice = {};
    String summary = '';
    double price = 0.0;
    for (var list in GetIt.I.get<ItemLayer>().prevCarts) {
      for (var map in list) {
        if (map['order_id'] == order.orderId) {
          itemAndPrice[map['item_name']] = map['item_price'];
          summary += '${map['quantity']}x ${map['item_name']}, ';
          price += map['item_price'] * map['quantity'];
        }
      }
    }
    return InkWell(
      overlayColor: WidgetStateColor.transparent,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        margin: const EdgeInsets.symmetric(vertical: 16),
        width: context.getWidth(),
        height: context.getWidth(divideBy: 2.8),
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
                  "Order No. ",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Average",
                      color: AppConstants.mainRed),
                ),
                Text(
                  '#${order.orderId.toString()}',
                  style: const TextStyle(fontSize: 20, fontFamily: "Average"),
                ),
              ],
            ),
            Text(
              summary.substring(0, summary.length - 2),
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              'Total Price : $price',
              style: const TextStyle(fontSize: 15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${order.orderDate?.split('T').first} | ${order.orderDate?.split('T')[1].split('.').first}',
                  style: const TextStyle(
                      color: AppConstants.subTextColor,
                      fontSize: 15,
                      fontFamily: "Average"),
                ),
                GestureDetector(
                  onTap: changeStatus,
                  child: Container(
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
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
