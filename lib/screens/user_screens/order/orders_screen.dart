import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/extensions/screen_nav.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/models/order_model.dart';
import 'package:project8/screens/user_screens/order/bloc/order_bloc.dart';
import 'package:project8/screens/user_screens/order/order_info_screen.dart';
import 'package:project8/widgets/cards/order_card.dart';
import 'package:project8/widgets/texts/page_title.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppConstants.mainBgColor,
        body: SafeArea(
          child: Column(
            children: [
              const PageTitle(title: "Orders"),
              const SizedBox(height: 10,),
              const TabBar(
                overlayColor: WidgetStateColor.transparent,
                unselectedLabelStyle:TextStyle(
                  fontFamily: "Average",
                  color: AppConstants.unselectedColor,
                  fontSize: 25,
                ),
                labelStyle: TextStyle(
                  fontFamily: "Average",
                  color: AppConstants.mainBlue,
                  fontSize: 25
                ),
                indicatorColor: AppConstants.mainBlue,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [Tab(text: "Waiting"), Text("Delivered")]
              ),
              Expanded(
                child: BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return SizedBox(
                        height: context.getHeight(divideBy: 3),
                        child: Center(child: LottieBuilder.asset("assets/images/Animation - 1727608827461.json")),
                      );
                    }
                    if (state is ErrorState) {
                      log("error loading orders");
                      return SizedBox(
                        height: context.getHeight(divideBy: 3),
                        child: const Center(child: Text("Error loading orders"))
                      );
                    }
                    if (state is SuccessState) {
                      if (GetIt.I.get<ItemLayer>().orders.isEmpty) {
                        return SizedBox(
                          height: context.getHeight(divideBy: 3),
                          child: const Center(child: Text("No Orders yet")),
                        );
                      }
                      else {
                        List<OrderModel> waiting = GetIt.I.get<ItemLayer>().orders.where((order)=>order.status=='Waiting').toList();
                        List<OrderModel> delivered = GetIt.I.get<ItemLayer>().orders.where((order)=>order.status=='Delivered').toList();
                        List<List<OrderModel>> statusList = [waiting,delivered];
                        return TabBarView(
                          children: List.generate(statusList.length,(statusIndex){
                            if(statusList[statusIndex].isEmpty) {
                              return const Text("data");
                            }
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: statusList[statusIndex].length,
                                      itemBuilder: (context, index) {
                                        OrderModel order = statusList[statusIndex][index];
                                        return OrderCard(
                                          order: order,
                                          onTap: () => context.push(screen: OrderInfoScreen(order: order)),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 70,)
                                ],
                              ),
                            );
                          })
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}