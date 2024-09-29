import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project8/constants/app_constants.dart';

class FavoritesCard extends StatelessWidget {
  final Image itemImage;
  final String name;
  final String price;
  final String cal;
  const FavoritesCard(
      {super.key,
      required this.itemImage,
      required this.name,
      required this.price,
      required this.cal});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 420,
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
              width: 170,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 232, 231, 231),
                  borderRadius: BorderRadius.circular(15)),
              child: itemImage,
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
                  name,
                  style: const TextStyle(fontSize: 22, fontFamily: "Average"),
                ),
                Text("$price SR",
                    style:
                        const TextStyle(fontSize: 16, fontFamily: "Average")),
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
                        const SizedBox(
                          width: 5,
                        ),
                        Text("$cal Cal"),
                      ],
                    ),
                    const SizedBox(
                      width: 100,
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
