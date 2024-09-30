import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/extensions/screen_nav.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/models/item_model.dart';
import 'package:project8/screens/user_screens/view_item.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;
  final Function()? onFav;
  const ItemCard({super.key, required this.item, this.onFav});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () => context.push(screen: ViewItem(item: item)),
      child: Container(
        width: 150,
        decoration: BoxDecoration(color: const Color(0xffF7F6F4),borderRadius: BorderRadius.circular(20)),
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
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Image.network(item.image),
              ),
              Text(item.name,style: const TextStyle(fontSize: 17, fontFamily: "Average")),
              Text("${item.price} SR", style: const TextStyle(fontSize: 12)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const FaIcon(FontAwesomeIcons.fireFlameCurved,size: 15,color: AppConstants.mainRed,),
                      const SizedBox(width: 5,),
                      Text("${item.calories} Cal"),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: onFav,
                      isSelected: false,
                      selectedIcon: const Icon(Icons.favorite, color: AppConstants.mainRed),
                      icon: const Icon(Icons.favorite_border, color: AppConstants.unselectedColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}