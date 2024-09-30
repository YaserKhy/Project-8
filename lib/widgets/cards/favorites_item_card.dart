import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/models/item_model.dart';

class FavoritesCard extends StatelessWidget {
  final ItemModel favItem;
  const FavoritesCard({super.key, required this.favItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      width: context.getWidth(divideBy: 1.1),
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
              width: context.getWidth(divideBy: 3),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 232, 231, 231),
                  borderRadius: BorderRadius.circular(15)),
              child: Image.network(favItem.image),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  favItem.name,
                  style: const TextStyle(fontSize: 22, fontFamily: "Average"),
                ),
                Text("${favItem.price} SR",
                    style:
                        const TextStyle(fontSize: 16, fontFamily: "Average")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                          Text("${favItem.calories} Cal"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite,
                            color: AppConstants.mainRed))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
