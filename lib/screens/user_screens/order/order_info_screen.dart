import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/data_layers/auth_layer.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/models/order_model.dart';
import 'package:project8/screens/user_screens/order/bloc/order_bloc.dart';
import 'package:project8/widgets/texts/category_title.dart';
import 'package:project8/widgets/other/custom_steppr.dart';
import 'package:project8/widgets/texts/order_text.dart';
import 'package:project8/widgets/texts/payment_text.dart';

class OrderInfoScreen extends StatelessWidget {
  final OrderModel order;
  const OrderInfoScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> itemAndPrice = {};
    double price = 0.0;
    List<int> quantities = [];
    for (var list in GetIt.I.get<ItemLayer>().prevCarts) {
      for (var map in list) {
        if(map['order_id']==order.orderId) {
          itemAndPrice[map['item_name']] = map['item_price'];
          quantities.add(map['quantity']);
          price+=map['item_price']*map['quantity'];
        }
      }
    }
    return BlocProvider(
      create: (context) => OrderBloc(),
      child: Builder(builder: (context) {
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
                  BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                      return CustomSteppr(
                        activeStep: GetIt.I.get<ItemLayer>().statuses.indexOf(order.status!),
                      );
                    },
                  ),
                  const CategoryTitle(title: "Order details"),
                  const SizedBox(height: 20),
                  OrderText(title: "Order No. ",content: '#${order.orderId}'),
                  const SizedBox(height: 20),
                  OrderText(title: "Order time: ", content: '${order.orderDate?.split('T').first} | ${order.orderDate?.split('T')[1].split('.').first.substring(0,5)}'),
                  const SizedBox(height: 20),
                  OrderText(title: "Customer name: ", content: GetIt.I.get<AuthLayer>().customer!.name),
                  const SizedBox(height: 20),
                  OrderText(title: "Customer Phone: ", content: GetIt.I.get<AuthLayer>().customer!.phoneNumber),
                  const SizedBox(height: 20),
                  const CategoryTitle(title: "Payment details"),
                  Column(
                    children: List.generate(itemAndPrice.length, (index){
                      return Column(
                        children: [
                          PaymentText(
                            item: '${quantities[index]}x ${itemAndPrice.keys.toList()[index]}',
                            price: (itemAndPrice.values.toList()[index]*quantities[index]).toString()
                          ),
                          const SizedBox(height: 20)
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: List.generate(
                      150 ~/ 6,
                      (index) => Expanded(
                        child: Container(
                          color: index % 2 == 0 ? Colors.transparent : AppConstants.mainRed,
                          height: 2,
                        ),
                      )
                    ),
                  ),
                  const SizedBox(height: 20),
                  PaymentText(item: "Total", price: price.toString()),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}