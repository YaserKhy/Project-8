
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/helpers/send_notification.dart';
import 'package:project8/screens/user_screens/order/bloc/order_bloc.dart';
import 'package:project8/widgets/texts/category_title.dart';
import 'package:project8/widgets/other/custom_steppr.dart';
import 'package:project8/widgets/texts/order_text.dart';
import 'package:project8/widgets/texts/payment_text.dart';

class OrderInfoScreen extends StatelessWidget {
  const OrderInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<OrderBloc>();
        int activeStep = bloc.activeStep;
        return Scaffold(
          backgroundColor: AppConstants.mainBgColor,
          appBar: AppBar(
            backgroundColor: AppConstants.mainBgColor,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: AppConstants.mainBlue,
                        foregroundColor: Colors.white),
                    onPressed: () async {
                      activeStep = activeStep + 1;
                      if (activeStep >= 2) {
                        bloc.add(ChangeIndcatorEvent());
                        await sendNotification();
                      }
                      bloc.add(ChangeIndcatorEvent());
                    },
                    child: const Text("Done")),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                      return CustomSteppr(
                        activeStep: activeStep,
                        onStepReached: (index) => activeStep = index,
                      );
                    },
                  ),
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
      }),
    );
  }
}
