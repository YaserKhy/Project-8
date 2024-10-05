import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/models/item_model.dart';
import 'package:project8/screens/user_screens/Favorite/bloc/favorite_bloc.dart';

class FavoritesCard extends StatelessWidget {
  final ItemModel favItem;
  final Function()? onView;
  const FavoritesCard({super.key, required this.favItem, this.onView});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FavoriteBloc>();
    return InkWell(
      overlayColor: WidgetStateColor.transparent,
      onTap: onView,
      child: Container(
        height: 135,
        width: context.getWidth(divideBy: 1.1),
        decoration: BoxDecoration(
          color: const Color(0xffF7F6F4),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 191, 191, 191).withOpacity(0.8),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(6, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 100,
                width: context.getWidth(divideBy: 3),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 232, 231, 231),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Image.network(favItem.image),
              ),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(favItem.name,style: Theme.of(context).textTheme.titleLarge),
                  Text("${favItem.price} SR", style:Theme.of(context).textTheme.headlineSmall),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 70,
                        child: Row(
                          children: [
                            const FaIcon(FontAwesomeIcons.fireFlameCurved,size: 15,color: AppConstants.mainRed,),
                            const SizedBox(width: 5,),
                            Text("${favItem.calories} Cal",style: Theme.of(context).textTheme.headlineSmall),
                          ],
                        ),
                      ),
                      const SizedBox(width: 80,),
                      IconButton(
                        onPressed: () => bloc.add(ToggleFavoriteEvent(item: favItem)),
                        icon: const Icon(Icons.favorite,color: AppConstants.mainRed)
                      )
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