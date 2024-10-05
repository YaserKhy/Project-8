import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/data_layers/auth_layer.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/models/item_model.dart';
import 'package:project8/screens/user_screens/Favorite/bloc/favorite_bloc.dart' as fav_bloc;

class ItemCard extends StatelessWidget {
  final ItemModel item;
  final Function()? onView;
  const ItemCard({super.key, required this.item, this.onView});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => fav_bloc.FavoriteBloc(),
      child: Builder(builder: (context) {
        final favbloc = context.read<fav_bloc.FavoriteBloc>();
        return InkWell(
          splashColor: Colors.transparent,
          onTap: onView,
          child: Container(
            width: 150,
            decoration: BoxDecoration(
              color: const Color(0xffF7F6F4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: context.getWidth(),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 232, 231, 231),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.network(item.image),
                  ),
                  Text(item.name,style: Theme.of(context).textTheme.titleMedium),
                  Text("${item.price} SR", style:Theme.of(context).textTheme.titleSmall),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const FaIcon(FontAwesomeIcons.fireFlameCurved,size: 15,color: AppConstants.mainRed,),
                          const SizedBox(width: 5),
                          Text("${item.calories} Cal",style: Theme.of(context).textTheme.titleSmall),
                        ],
                      ),
                      BlocBuilder<fav_bloc.FavoriteBloc,fav_bloc.FavoriteState>(
                        builder: (context, state) {
                          final isFavorite = GetIt.I.get<ItemLayer>().favItems.map((item) => item.itemId).toList().contains(item.itemId);
                          return SizedBox(
                            height: 40,
                            width: 40,
                            child: IconButton(
                              isSelected: isFavorite,
                              selectedIcon: const Icon(Icons.favorite,color: AppConstants.mainRed),
                              icon: const Icon(Icons.favorite_border),
                              onPressed: () {
                                GetIt.I.get<AuthLayer>().isGuest() == false
                                ? favbloc.add(fav_bloc.ToggleFavoriteEvent(item: item))
                                : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.only(bottom: 65.0),
                                    content: Text("You must login first"),
                                  )
                                );
                              }
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}