import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/models/cart_item_model.dart';
import 'package:project8/models/item_model.dart';
import 'package:project8/screens/user_screens/cart/bloc/cart_bloc.dart';

class CartCard extends StatelessWidget {
  final CartItemModel cartItem;
  void Function()? onDelete;
  CartCard({super.key, required this.cartItem, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    log(GetIt.I.get<ItemLayer>().cartItems.toString());
    final item = GetIt.I
        .get<ItemLayer>()
        .items
        .where((item) => item.itemId == cartItem.itemId)
        .first;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 125,
        width: context.getWidth(),
        decoration: BoxDecoration(
          color: const Color(0xffF7F6F4),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 191, 191, 191)
                  .withOpacity(0.8), // Shadow color
              spreadRadius: 3, // Spread of the shadow
              blurRadius: 5, // Softness of the shadow
              offset: const Offset(6, 6), // Horizontal and vertical offset
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 100,
                width: context.getWidth(divideBy: 3.9),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 232, 231, 231),
                    borderRadius: BorderRadius.circular(15)),
                child: Image.network(item.image),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    item.name,
                    style: const TextStyle(
                        fontSize: 17,
                        fontFamily: "Average",
                        overflow: TextOverflow.ellipsis),
                  ),
                  SizedBox(
                    width: 70,
                    child: Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.fireFlameCurved,
                          size: 15,
                          color: AppConstants.mainRed,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text("${item.calories} Cal",
                            style: const TextStyle(fontFamily: "Average")),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("${item.price} SR",
                      style:
                          const TextStyle(fontSize: 16, fontFamily: "Average")),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: onDelete,
                      icon: const Icon(
                        Icons.delete,
                        size: 20,
                        color: AppConstants.mainRed,
                      )),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            cartItem.quantity--;
                            print(cartItem.quantity);
                          },
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            size: 20,
                          )),
                      BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          return Text("${cartItem.quantity}");
                        },
                      ),
                      IconButton(
                          onPressed: () {
                            cartItem.quantity++;
                          },
                          icon: const Icon(Icons.add_circle_outline, size: 20)),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
