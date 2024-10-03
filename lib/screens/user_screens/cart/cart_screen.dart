import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/data_layers/supabase_layer.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/helpers/helper.dart';
import 'package:project8/screens/user_screens/cart/bloc/cart_bloc.dart';
import 'package:project8/widgets/cards/cart_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc()..add(GetAllCartItemsEvent()),
      child: Builder(builder: (context) {
        final bloc = context.read<CartBloc>();

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstants.mainBgColor,
            centerTitle: true,
            title: const Text("Cart",
                style: TextStyle(fontFamily: "Average", fontSize: 32)),
          ),
          backgroundColor: AppConstants.mainBgColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  getMatchingCartItems();
                  log(GetIt.I.get<ItemLayer>().cartItems.toString());
                  log(GetIt.I
                      .get<ItemLayer>()
                      .matchingCartItems
                      .length
                      .toString());
                  log(GetIt.I
                      .get<ItemLayer>()
                      .matchingCartItems
                      .length
                      .toString());
                  if (state is LoadingState) {
                    return SizedBox(
                        height: context.getHeight(divideBy: 3),
                        child: Center(
                            child: LottieBuilder.asset(
                                "assets/images/Animation - 1727608827461.json")));
                  }
                  if (state is SuccessState) {
                    if (GetIt.I.get<ItemLayer>().matchingCartItems.isEmpty) {
                      return const Center(child: Text("Cart is empty"));
                    } else {
                      return Column(
                          children: GetIt.I
                              .get<ItemLayer>()
                              .matchingCartItems
                              .map((item) => CartCard(
                                    cartItem: item,
                                    onDelete: () async {
                                      await GetIt.I
                                          .get<SupabaseLayer>()
                                          .deleteCartItem(itemId: item.itemId);
                                      bloc.add(GetAllCartItemsEvent());
                                    },
                                  ))
                              .toList());
                    }
                  }
                  if (state is ErrorState) {
                    log("error loading cart items");
                    return SizedBox(
                        height: context.getHeight(divideBy: 3),
                        child:
                            const Center(child: Text("Error loading items")));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
