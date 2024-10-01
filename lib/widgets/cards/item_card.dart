import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/extensions/screen_nav.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/models/item_model.dart';
import 'package:project8/screens/user_screens/home/bloc/home_bloc.dart';
import 'package:project8/screens/user_screens/view_item.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;
  const ItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: WidgetStateColor.transparent,
      onTap: () => context.push(screen: ViewItem(item: item)),
      child: Container(
        height: 211,
        width: 175,
        decoration: BoxDecoration(
          color: const Color(0xffF7F6F4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 175,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 232, 231, 231),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.network(item.image),
              ),
              Text(
                item.name,
                style: const TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis),
              ),
              Text("${item.price} SR", style: const TextStyle(fontSize: 12)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.fireFlameCurved,
                        size: 15,
                        color: AppConstants.mainRed,
                      ),
                      const SizedBox(width: 5),
                      Text("${item.calories} Cal"),
                    ],
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is SuccessState) {
                        // log("currently fav is");
                        // log(state.favorites.map((item)=>item.name).toList().toString());
                        final isFavorite = state.favorites.map((item)=>item.itemId).toList().contains(item.itemId);
                        // log(item.name);
                        // log(isFavorite.toString());
                        return IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? AppConstants.mainRed : null,
                          ),
                          onPressed: () {
                            context.read<HomeBloc>().add(ToggleFavoriteEvent(item: item));
                          },
                        );
                      }
                      return const SizedBox.shrink(); // Default fallback
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}