import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/models/cart_item_model.dart';
import 'package:project8/screens/user_screens/cart/bloc/cart_bloc.dart';

class CartCard extends StatelessWidget {
  final CartItemModel cartItem;
  final Function()? onDelete;
  final Function() onIncreaseQuantity;
  final Function() onDecreaseQuantity;
  const CartCard({super.key, required this.cartItem, required this.onDelete, required this.onIncreaseQuantity, required this.onDecreaseQuantity});

  @override
  Widget build(BuildContext context) {
    final item = GetIt.I.get<ItemLayer>().items.where((item) => item.itemId == cartItem.itemId).first;
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
              color: const Color.fromARGB(255, 191, 191, 191).withOpacity(0.8), // Shadow color
              spreadRadius: 3, // Spread of the shadow
              blurRadius: 5, // Softness of the shadow
              offset: const Offset(6, 6), // Horizontal and vertical offset
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 100,
                    width: context.getWidth(divideBy: 3.9),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 232, 231, 231),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Image.network(item.image),
                  ),
                  const SizedBox(width: 10,),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        Text(item.name,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.headlineMedium),
                        SizedBox(
                          width: 70,
                          child: Row(
                            children: [
                              const FaIcon(FontAwesomeIcons.fireFlameCurved,size: 15,color: AppConstants.mainRed,),
                              const SizedBox(width: 5,),
                              Text("${item.calories} Cal",style: Theme.of(context).textTheme.headlineSmall,),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text("${item.price} SR",style: Theme.of(context).textTheme.headlineSmall),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete,size: 20,color: AppConstants.mainRed,)
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: onDecreaseQuantity,
                        icon: const Icon(Icons.remove_circle_outline,size: 20,)
                      ),
                      BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          return Text("${cartItem.quantity}", style: Theme.of(context).textTheme.headlineMedium,);
                        },
                      ),
                      IconButton(
                        onPressed: onIncreaseQuantity,
                        icon: const Icon(Icons.add_circle_outline, size: 20)
                      ),
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