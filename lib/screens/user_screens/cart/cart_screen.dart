import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/screens/user_screens/cart/bloc/cart_bloc.dart';
import 'package:project8/widgets/cards/cart_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc()..add(GetAllCartItemsEvent()),
      child: Builder(builder: (context) {
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
              child: Column(
                children: [
                  CartCard(
                    item: GetIt.I.get<ItemLayer>().items[0],
                    qty: 5,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.read<CartBloc>().add(GetAllCartItemsEvent());
                        print(GetIt.I.get<ItemLayer>().cartItems);
                      },
                      child: Text("Asdf"))
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
