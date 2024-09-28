import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project8/constants/app_constants.dart';

class ItemCard extends StatelessWidget {
  final Image itemImage;
  final String name;
  final String price;
  final String cal;
  const ItemCard({super.key,required this.itemImage,required this.name,required this.price,required this.cal,});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 211,
      width: 175,
      decoration: BoxDecoration(
        color: const Color(0xffF7F6F4),
        borderRadius: BorderRadius.circular(20)
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
                borderRadius: BorderRadius.circular(15)
              ),
              child: itemImage,
            ),
            Text(name,style: const TextStyle(fontSize: 18),),
            Text("$price SR", style: const TextStyle(fontSize: 12)),
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
                    const SizedBox(width: 5,),
                    Text("$cal Cal"),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border_rounded)
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
