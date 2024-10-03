import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/screens/user_screens/order/bloc/order_bloc.dart';
import 'package:project8/widgets/other/custom_tapbar.dart';
import 'package:project8/widgets/texts/page_title.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<OrderBloc>()..add(GetOrdersEvent());
        return Scaffold(
          backgroundColor: AppConstants.mainBgColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return SizedBox(
                      height: context.getHeight(divideBy: 3),
                      child: Center(
                          child: LottieBuilder.asset(
                                "assets/images/Animation - 1727608827461.json")));
                  }
                  if (state is ErrorState) {
                    log("error loading orders");
                    return SizedBox(
                        height: context.getHeight(divideBy: 3),
                        child: const Center(
                            child: Text("Error loading orders")));
                  }
                  if(state is SuccessState) {
                    if(GetIt.I.get<ItemLayer>().orders.isEmpty) {
                      return SizedBox(
                        height: context.getHeight(divideBy: 3),
                        child: const Center(child: Text("No Orders yet"),),
                      );
                    }
                    else {
                      return DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            const PageTitle(title: "Orders"),
                            const SizedBox(height: 10,),
                            const CustomTapbar(),
                            ...GetIt.I.get<ItemLayer>().orders.map((o)=>Text(o['cart_id'])),
                          ]
                        ),
                      );
                    }
                  }
                  return const SizedBox.shrink();
                },
              ),
              // child: DefaultTabController(
              //   length: 2,
              //   child: Column(
              //     children: [
              //       const PageTitle(title: "Orders"),
              //       const SizedBox(height: 10),
              //       const CustomTapbar(),
              //       OrderCard(
              //           onTap: () => context.push(screen: const OrderInfoScreen()),
              //           order:
              //               "hdskjdjfsjfjddjkdkdkssjkdkjfhjeikdjjddkkdkdkdkdkkdk",
              //           orderDate: "25/09/2024, 5:25 PM",
              //           status: "In progress")
              //     ],
              //   ),
              // ),
            ),
          ),
        );
      }),
    );
  }
}
