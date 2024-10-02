import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/extensions/screen_nav.dart';
import 'package:project8/screens/user_screens/order/order_info_screen.dart';

import 'package:project8/widgets/cards/order_card.dart';
import 'package:project8/widgets/other/custom_tapbar.dart';
import 'package:project8/widgets/texts/page_title.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.mainBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const PageTitle(title: "Orders"),
                const SizedBox(height: 10),
                const CustomTapbar(),
                OrderCard(
                    onTap: () => context.push(screen: const OrderInfoScreen()),
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
