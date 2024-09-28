import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:project8/widgets/cards/item_card.dart';
import 'package:project8/widgets/fields/search_feild.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      backgroundColor: const Color(0xffEEEDEA),
      body: SafeArea(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 53,
                      child: Image.asset(
                        "assets/images/default_profile_img.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Coffee Addict",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text("Sara",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))
                    ],
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_none_outlined,
                    size: 30,
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              // Add ClipRRect here to apply the border radius
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                height: context.getHeight(divideBy: 5),
                width: context.getWidth(),
                child: ImageSlideshow(
                  indicatorColor: const Color(0xffD9D9D9),
                  indicatorBackgroundColor: const Color(0xff717171),
                  onPageChanged: (value) {
                    debugPrint('Page changed: $value');
                  },
                  autoPlayInterval: 7000,
                  isLoop: true,
                  children: [
                    Image.asset(
                      'assets/images/image_slider_1.png',
                      fit: BoxFit.fill,
                    ),
                    Image.asset(
                      'assets/images/image_slider_1.png',
                      fit: BoxFit.fill,
                    ),
                    Image.asset(
                      'assets/images/image_slider_1.png',
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SearchField(
            title: "Search",
            controller: searchController,
            prefixIcon: Icons.search,
          ),
          const SizedBox(
            height: 20,
          ),
          ItemCard(
            itemImage: Image.asset("assets/images/default_profile_img.png"),
            name: "Cortado",
            price: "12.00",
            cal: "50",
          ),
        ],
      )),
    );
  }
}
