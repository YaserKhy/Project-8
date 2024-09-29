import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:project8/screens/user_screens/home/bloc/home_bloc.dart';
import 'package:project8/widgets/cards/item_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project8/widgets/fields/search_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return BlocProvider(
      create: (context) => HomeBloc()..add(GetAllItemsEvent()),
      child: Builder(builder: (context) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: AppConstants.mainBgColor,
            body: SafeArea(
                // content
                child: SingleChildScrollView(
              child: Column(
                children: [
                  // appbar is a row with two children, profile info row and notifications
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // profile info
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
                          // welcome and name
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Welcome Coffee Addict",
                                  style: TextStyle(
                                      fontFamily: "Average", fontSize: 16)),
                              Text("Sara",
                                  style: TextStyle(
                                      fontFamily: "Average",
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ],
                      ),
                      // notification button
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications_none_outlined,
                              size: 30))
                    ],
                  ),
                  // slider
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      // Add ClipRRect here to apply the border radius
                      borderRadius: BorderRadius.circular(15),
                      child: SizedBox(
                        height: context.getHeight(divideBy: 5),
                        width: context.getWidth(),
                        child: ImageSlideshow(
                          indicatorColor: AppConstants.mainWhite,
                          indicatorBackgroundColor: const Color(0xff717171),
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
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is LoadingState) {
                        log("loading");
                        return const Center(
                          child: Text("loading"),
                        );
                      }
                      if (state is SuccessState) {
                        log("success");
                        return Column(
                          children: GetIt.I.get<ItemLayer>().items.map((item) {
                            return ItemCard(item: item);
                          }).toList(),
                        );
                      }
                      if (state is Error) {
                        return const Center(
                          child: Text("error"),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            )),
          ),
        );
      }),
    );
  }
}
