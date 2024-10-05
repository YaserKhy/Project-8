import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/data_layers/supabase_layer.dart';
import 'package:project8/extensions/screen_nav.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/models/order_model.dart';
import 'package:project8/screens/employee_screens/employee_orders/bloc/employee_orders_bloc.dart';
import 'package:project8/screens/user_screens/order/order_info_screen.dart';
import 'package:project8/widgets/cards/employee_order_card.dart';
import 'package:project8/widgets/texts/page_title.dart';

class EmployeeOrdersScreen extends StatelessWidget {
  const EmployeeOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeOrdersBloc()..add(GetOrdersEvent()),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppConstants.mainBgColor,
          body: SafeArea(
            child: Column(
              children: [
                const PageTitle(title: "Orders"),
                const SizedBox(
                  height: 10,
                ),
                const TabBar(
                    unselectedLabelStyle: TextStyle(
                      fontFamily: "Average",
                      color: AppConstants.unselectedColor,
                      fontSize: 25,
                    ),
                    labelStyle: TextStyle(
                        fontFamily: "Average",
                        color: AppConstants.mainBlue,
                        fontSize: 25),
                    indicatorColor: AppConstants.mainBlue,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Tab(text: "Current"),
                      Tab(text: "Done"),
                    ]),
                Expanded(
                  child: BlocBuilder<EmployeeOrdersBloc, EmployeeOrdersState>(
                    builder: (context, state) {
                      if (state is LoadingState) {
                        log("loading state");

                        return SizedBox(
                          height: context.getHeight(divideBy: 3),
                          child: Center(
                              child: LottieBuilder.asset(
                                  "assets/images/Animation - 1727608827461.json")),
                        );
                      }
                      if (state is ErrorState) {
                        log("error loading orders");
                        return SizedBox(
                            height: context.getHeight(divideBy: 3),
                            child: const Center(
                                child: Text("Error loading orders")));
                      }
                      if (state is SuccessState) {
                        log("success state");
                        if (GetIt.I.get<ItemLayer>().orders.isEmpty) {
                          return SizedBox(
                            height: context.getHeight(divideBy: 3),
                            child: const Center(child: Text("No Orders yet")),
                          );
                        } else {
                          List<OrderModel> waiting = GetIt.I
                              .get<ItemLayer>()
                              .orders
                              .where((order) =>
                                  order.status == 'Waiting' ||
                                  order.status == 'Preparing' ||
                                  order.status == 'Ready')
                              .toList()
                            ..sort((a, b) => a.orderId.compareTo(b.orderId));

                          List<OrderModel> done = GetIt.I
                              .get<ItemLayer>()
                              .orders
                              .where((order) => order.status == 'Done')
                              .toList()
                            ..sort((a, b) => a.orderId.compareTo(b.orderId));
                          List<List<OrderModel>> statusList = [
                            waiting,
                            done,
                          ];
                          return TabBarView(
                              children: List.generate(statusList.length,
                                  (statusIndex) {
                            if (statusList[statusIndex].isEmpty) {
                              return const Text("data");
                            }
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Expanded(
  child: StreamBuilder(
  stream: GetIt.I.get<SupabaseLayer>().employeeRealTimeGetOrders(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    }

    if (snapshot.hasData) {
      return FutureBuilder(
        future: GetIt.I.get<SupabaseLayer>().employeeGetOrders(),
        builder: (context, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (futureSnapshot.hasError) {
            return Center(child: Text('Error: ${futureSnapshot.error}'));
          }

          if (futureSnapshot.connectionState == ConnectionState.done) {
            List<OrderModel> waiting = GetIt.I.get<ItemLayer>().orders
                .where((order) =>
                    order.status == 'Waiting' ||
                    order.status == 'Preparing' ||
                    order.status == 'Ready')
                .toList()
              ..sort((a, b) => a.orderId.compareTo(b.orderId));

            List<OrderModel> done = GetIt.I.get<ItemLayer>().orders
                .where((order) => order.status == 'Done')
                .toList()
              ..sort((a, b) => a.orderId.compareTo(b.orderId));

            List<List<OrderModel>> statusList = [waiting, done];

            return TabBarView(
              children: List.generate(statusList.length, (statusIndex) {
                if (statusList[statusIndex].isEmpty) {
                  return const Center(child: Text("No Orders yet"));
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: statusList[statusIndex].length,
                  itemBuilder: (context, index) {
                    OrderModel order = statusList[statusIndex][index];
                    return EmployeeOrderCard(
                      order: order,
                      onTap: () => context.push(
                        screen: OrderInfoScreen(order: order),
                      ),
                      changeStatus: () async {
                        log(order.orderId.toString());
                        int statusIndex = GetIt.I
                            .get<ItemLayer>()
                            .statuses
                            .indexOf(order.status!);

                        if (statusIndex <
                            GetIt.I.get<ItemLayer>().statuses.length - 1) {
                          await GetIt.I
                              .get<SupabaseLayer>()
                              .supabase
                              .from('orders')
                              .update({
                            'status': GetIt.I.get<ItemLayer>().statuses[
                                statusIndex + 1],
                          }).match({
                            'order_id': order.orderId,
                          });
                          context
                              .read<EmployeeOrdersBloc>()
                              .add(GetOrdersEvent());
                        }
                      },
                    );
                  },
                );
              }),
            );
          }

          return const SizedBox.shrink();
        },
      );
    }

    return const Center(child: Text('No orders available'));
  },
),
                              )],
                              ),
                            );
                          }));
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
      ),
    );
  }
}