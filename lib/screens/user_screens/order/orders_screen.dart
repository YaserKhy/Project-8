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
              const SizedBox(
                height: 10,
              ),
              TabBar(
                  overlayColor: WidgetStateColor.transparent,
                  unselectedLabelStyle: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: AppConstants.unselectedColor),
                  labelStyle: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: AppConstants.mainBlue),
                  indicatorColor: AppConstants.mainBlue,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [Tab(text: "Current"), Text("Done")]),
              Expanded(
                child: BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return SizedBox(
                        height: context.getHeight(divideBy: 3),
                        child: Center(
                            child: LottieBuilder.asset(
                                "assets/images/Animation - 1727608827461.json")),
                      );
                    }
                    if (state is ErrorState) {
                      return SizedBox(
                          height: context.getHeight(divideBy: 3),
                          child: const Center(
                              child: Text("Error loading orders")));
                    }
                    if (state is SuccessState) {
                      if (GetIt.I.get<ItemLayer>().orders.isEmpty) {
                        return SizedBox(
                          height: context.getHeight(divideBy: 3),
                          child: Center(
                              child: Text("No Orders yet",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium)),
                        );
                      } else {
                        List<OrderModel> currentOrders = GetIt.I
                            .get<ItemLayer>()
                            .orders
                            .where((order) => order.status != 'Done')
                            .toList();
                        List<OrderModel> doneOrders = GetIt.I
                            .get<ItemLayer>()
                            .orders
                            .where((order) => order.status == 'Done')
                            .toList();
                        List<List<OrderModel>> statusList = [
                          currentOrders,
                          doneOrders
                        ];
                        return TabBarView(
                            children:
                                List.generate(statusList.length, (statusIndex) {
                          if (statusList[statusIndex].isEmpty) {
                            return SizedBox(
                              height: context.getHeight(divideBy: 3),
                              child: Center(
                                  child: Text("No Orders yet",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium)),
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: RefreshIndicator(
                                    onRefresh: () async {
                                      context
                                          .read<OrderBloc>()
                                          .add(GetOrdersEvent());
                                      // Optionally add some delay to simulate refresh
                                      await Future.delayed(
                                          const Duration(seconds: 1));
                                    },
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: statusList[statusIndex].length,
                                      itemBuilder: (context, index) {
                                        OrderModel order =
                                            statusList[statusIndex][index];
                                        return OrderCard(
                                          order: order,
                                          onTap: () => context.push(
                                              screen: OrderInfoScreen(
                                                  order: order)),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 70,
                                )
                              ],
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
    );
  }
}
