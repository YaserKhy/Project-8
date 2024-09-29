import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';

import 'package:project8/widgets/cards/order_card.dart';
import 'package:project8/widgets/other/custom_tapbar.dart';
import 'package:project8/widgets/other/page_title.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppConstants.mainBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                PageTitle(title: "Orders"),
                SizedBox(height: 10),
                CustomTapbar(),
                OrderCard(
                    order:
                        "hdskjdjfsjfjddjkdkdkssjkdkjfhjeikdjjddkkdkdkdkdkkdk",
                    orderDate: "25/09/2024, 5:25 PM",
                    status: "In progress")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
