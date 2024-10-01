import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/data_layers/auth_layer.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/helpers/helper.dart';
// import 'package:project8/screens/user_screens/Favorite/bloc/favorite_bloc.dart' as fav_bloc;
import 'package:project8/screens/user_screens/home/bloc/home_bloc.dart';
import 'package:project8/screens/user_screens/home/image_slider.dart';
import 'package:project8/widgets/cards/item_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project8/widgets/other/category_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppConstants.mainBgColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom:8),
                    child: Row(
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
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Welcome Coffee Addict",
                                  style: TextStyle(
                                      fontFamily: "Average", fontSize: 16),
                                ),
                                Text(
                                  GetIt.I.get<AuthLayer>().customer!.name,
                                  style: const TextStyle(
                                      fontFamily: "Average",
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications_none_outlined,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const ImageSlider(),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      final bloc = context.read<HomeBloc>();
                      if (state is LoadingState) {
                        log("loading items");
                        return SizedBox(
                          height: context.getHeight(divideBy: 3),
                          child: Center(child: LottieBuilder.asset("assets/images/Animation - 1727608827461.json"))
                        );
                      }
                      if (state is ErrorState) {
                        log("error loading items");
                        return SizedBox(
                          height: context.getHeight(divideBy: 3),
                          child: const Center(child: Text("Error loading items"))
                        );
                      }
                      if (state is SuccessState) {
                        final itemLayer = GetIt.I.get<ItemLayer>();
                        final groupedItems = groupItemsByCategory(itemLayer.items);
                        final selectedCategory = state.selectedCategory;
                        final itemsToDisplay = selectedCategory == 'All'
                            ? itemLayer.items
                            : groupedItems[selectedCategory] ?? [];
                        return DefaultTabController(
                                  length: itemLayer.categories.length,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const CategoryTitle(title: "Best Seller"),
                                      // best seller
                                      SizedBox(
                                        height: 211,
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: getBestSellers().length,
                                          separatorBuilder: (context, index) => const SizedBox(width: 10),
                                          itemBuilder: (context, index) => ItemCard(item: getBestSellers()[index]),
                                        ),
                                      ),
                                      // tabbar
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 20),
                                        child: TabBar(
                                          onTap: (index) => bloc.add(ChangeCategoryEvent(category:itemLayer.categories[index])),
                                          tabAlignment: TabAlignment.start,
                                          overlayColor: WidgetStateColor.transparent,
                                          padding: EdgeInsets.zero,
                                          indicatorPadding: EdgeInsets.zero,
                                          labelPadding: EdgeInsets.zero,
                                          isScrollable: true,
                                          dividerColor: Colors.transparent,
                                          indicatorColor: Colors.transparent,
                                          tabs: itemLayer.categories.map((category) {
                                            final isSelected = selectedCategory == category;
                                            return Container(
                                              margin: const EdgeInsets.symmetric(horizontal: 10),
                                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                              decoration: BoxDecoration(
                                                color: isSelected ? AppConstants.mainBlue : Colors.white,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                category,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: isSelected ? AppConstants.mainBgColor : Colors.black,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      // if all is selected
                                      selectedCategory == 'All'
                                      ? ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: groupedItems.length,
                                        itemBuilder: (context, index) {
                                          final category = groupedItems.keys.toList()[index];
                                          final items = groupedItems[category];
                                          return Column(
                                            children: [
                                              CategoryTitle(title: category),
                                              GridView.builder(
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 1.69 / 2,
                                                  crossAxisSpacing: 10,
                                                  mainAxisSpacing: 10,
                                                ),
                                                itemCount: items!.length,
                                                itemBuilder: (context, index) {
                                                  return ItemCard(
                                                    item: items[index],
                                                    homeBloc: bloc,
                                                  );
                                                }
                                              )
                                            ],
                                          );
                                        }
                                      )
                                      // if specific category is selected
                                      : GridView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 1.69 / 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                        ),
                                        itemCount: itemsToDisplay.length,
                                        itemBuilder: (context, index) {
                                          final item = itemsToDisplay[index];
                                          return ItemCard(
                                            item: item,
                                            homeBloc: bloc,
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            ),
          )
        )
      )
    );
  }
}

// return BlocProvider(
//       create: (context) => fav_bloc.FavoriteBloc(),
//       child: Builder(
//         builder: (context) {
//           final favbloc = context.read<fav_bloc.FavoriteBloc>();
//           return GestureDetector(
//             onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//             child: Scaffold(
//               backgroundColor: AppConstants.mainBgColor,
//               body: SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         // appbar
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 16),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   Image.asset("assets/images/default_profile_img.png",fit: BoxFit.cover),
//                                   const SizedBox(width: 10),
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       const Text("Welcome Coffee Addict",style: TextStyle(fontFamily: "Average", fontSize: 16)),
//                                       Text(
//                                         GetIt.I.get<AuthLayer>().customer!.name,
//                                         style: const TextStyle(fontFamily: "Average",fontSize: 18,fontWeight: FontWeight.bold)
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               IconButton(
//                                 onPressed: () {},
//                                 icon: const Icon(Icons.notifications_none_outlined,size: 30,),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const ImageSlider(),
//                         BlocBuilder<HomeBloc, HomeState>(
//                           builder: (context, state) {
//                             if (state is LoadingState) {
//                               log("loading items");
//                               return SizedBox(
//                                 height: context.getHeight(divideBy: 3),
//                                 child: Center(child: LottieBuilder.asset("assets/images/Animation - 1727608827461.json"))
//                               );
//                             }
//                             if (state is ErrorState) {
//                               log("error loading items");
//                               return SizedBox(
//                                 height: context.getHeight(divideBy: 3),
//                                 child: const Center(child: Text("Error loading items"))
//                               );
//                             }
//                             if (state is SuccessState) {
//                               final itemLayer = GetIt.I.get<ItemLayer>();
//                               final groupedItems = groupItemsByCategory(itemLayer.items);
//                               log(groupedItems.toString());
//                               final selectedCategory = state.selectedCategory;
//                               final itemsToDisplay = selectedCategory == 'All' ? itemLayer.items : groupedItems[selectedCategory] ?? [];
//                               return DefaultTabController(
//                                 length: itemLayer.categories.length,
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     const CategoryTitle(title: "Best Seller"),
//                                     // best seller
//                                     SizedBox(
//                                       height: 211,
//                                       child: ListView.separated(
//                                         scrollDirection: Axis.horizontal,
//                                         itemCount: getBestSellers().length,
//                                         separatorBuilder: (context, index) => const SizedBox(width: 10),
//                                         itemBuilder: (context, index) => ItemCard(item: getBestSellers()[index]),
//                                       ),
//                                     ),
//                                     // tabbar
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(vertical: 20),
//                                       child: TabBar(
//                                         onTap: (index) => context.read<HomeBloc>().add(ChangeCategoryEvent(category:itemLayer.categories[index])),
//                                         tabAlignment: TabAlignment.start,
//                                         overlayColor: WidgetStateColor.transparent,
//                                         padding: EdgeInsets.zero,
//                                         indicatorPadding: EdgeInsets.zero,
//                                         labelPadding: EdgeInsets.zero,
//                                         isScrollable: true,
//                                         dividerColor: Colors.transparent,
//                                         indicatorColor: Colors.transparent,
//                                         tabs: itemLayer.categories.map((category) {
//                                           final isSelected = selectedCategory == category;
//                                           return Container(
//                                             margin: const EdgeInsets.symmetric(horizontal: 10),
//                                             padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                                             decoration: BoxDecoration(
//                                               color: isSelected ? AppConstants.mainBlue : Colors.white,
//                                               borderRadius: BorderRadius.circular(10),
//                                             ),
//                                             child: Text(
//                                               category,
//                                               style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: isSelected ? AppConstants.mainBgColor : Colors.black,
//                                               ),
//                                             ),
//                                           );
//                                         }).toList(),
//                                       ),
//                                     ),
//                                     // if all is selected
//                                     selectedCategory == 'All'
//                                     ? ListView.builder(
//                                       physics: const NeverScrollableScrollPhysics(),
//                                       shrinkWrap: true,
//                                       itemCount: groupedItems.length,
//                                       itemBuilder: (context, index) {
//                                         final category = groupedItems.keys.toList()[index];
//                                         final items = groupedItems[category];
//                                         return Column(
//                                           children: [
//                                             CategoryTitle(title: category),
//                                             GridView.builder(
//                                               shrinkWrap: true,
//                                               physics: const NeverScrollableScrollPhysics(),
//                                               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                                 crossAxisCount: 2,
//                                                 childAspectRatio: 1.69 / 2,
//                                                 crossAxisSpacing: 10,
//                                                 mainAxisSpacing: 10,
//                                               ),
//                                               itemCount: items!.length,
//                                               itemBuilder: (context, index) {
//                                                 return ItemCard(
//                                                   item: items[index],
//                                                   onFav: () async {
//                                                     favbloc.add(fav_bloc.AddToFavEvent(itemId: items[index].itemId));
//                                                   }
//                                                 );
//                                               }
//                                             )
//                                           ],
//                                         );
//                                       }
//                                     )
//                                     // if specific category is selected
//                                     : GridView.builder(
//                                       shrinkWrap: true,
//                                       physics: const NeverScrollableScrollPhysics(),
//                                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                         crossAxisCount: 2,
//                                         childAspectRatio: 1.69 / 2,
//                                         crossAxisSpacing: 10,
//                                         mainAxisSpacing: 10,
//                                       ),
//                                       itemCount: itemsToDisplay.length,
//                                       itemBuilder: (context, index) {
//                                         final item = itemsToDisplay[index];
//                                         return ItemCard(
//                                           item: item,
//                                           onFav: () async {
//                                             favbloc.add(fav_bloc.AddToFavEvent(itemId: item.itemId));
//                                           }
//                                         );
//                                       },
//                                     ),
//                                     const SizedBox(height: 20),
//                                   ],
//                                 ),
//                               );
//                             }
//                             return const SizedBox.shrink();
//                           },
//                         ),
//                         const SizedBox(height: 70),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),