import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/widgets/texts/category_title.dart';
import 'package:project8/widgets/other/custom_steppr.dart';
import 'package:project8/widgets/texts/order_text.dart';
import 'package:project8/widgets/texts/payment_text.dart';

class OrderInfoScreen extends StatelessWidget {
  const OrderInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.mainBgColor,
      appBar: AppBar(
        backgroundColor: AppConstants.mainBgColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomSteppr(),
              const CategoryTitle(title: "Orders details"),
              const SizedBox(height: 20),
              const OrderText(
                title: "Order: ",
                content: "2x Coffee day, 3x Cappuccino, Cortado",
              ),
              const SizedBox(height: 20),
              const OrderText(
                  title: "Order time: ", content: "25/09/2024, 5:25 PM"),
              const SizedBox(height: 20),
              const OrderText(title: "Customer name: ", content: "name"),
              const SizedBox(height: 20),
              const OrderText(
                  title: "Customer Phone: ", content: "04463723678"),
              const SizedBox(height: 40),
              const CategoryTitle(title: "Payment details"),
              const PaymentText(item: "Coffee Day", price: "16.00"),
              const SizedBox(height: 20),
              const PaymentText(item: "Coffee Day", price: "16.00"),
              const SizedBox(height: 20),
              const PaymentText(item: "Coffee Day", price: "16.00"),
              const SizedBox(height: 20),
              const PaymentText(item: "Coffee Day", price: "16.00"),
              const SizedBox(height: 20),
              Row(
                children: List.generate(
                    150 ~/ 6,
                    (index) => Expanded(
                          child: Container(
                            color: index % 2 == 0
                                ? Colors.transparent
                                : AppConstants.mainRed,
                            height: 2,
                          ),
                        )),
              ),
              const SizedBox(height: 20),
              const PaymentText(item: "Total", price: "16.00"),
            ],
          ),
        ),
      ),
    );
  }
}
