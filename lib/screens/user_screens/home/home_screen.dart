// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:project8/constants/app_constants.dart';
// import 'package:project8/data_layers/auth_layer.dart';
// import 'package:project8/data_layers/item_layer.dart';
// import 'package:project8/data_layers/supabase_layer.dart';
// import 'package:project8/helpers/helper.dart';
// import 'package:project8/screens/user_screens/home/bloc/home_bloc.dart';
// import 'package:project8/screens/user_screens/home/image_slider.dart';
// import 'package:project8/widgets/cards/item_card.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//       child: Scaffold(
//         backgroundColor: AppConstants.mainBgColor,
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: SizedBox(
//                               height: 53,
//                               child: Image.asset(
//                                 "assets/images/default_profile_img.png",
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text("Welcome Coffee Addict",
//                                   style: TextStyle(
//                                       fontFamily: "Average", fontSize: 16)),
//                               Text(GetIt.I.get<AuthLayer>().customer!.name,
//                                   style: const TextStyle(
//                                       fontFamily: "Average",
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold)),
//                             ],
//                           ),
//                         ],
//                       ),
//                       IconButton(
//                         onPressed: () {},
//                         icon: const Icon(
//                           Icons.notifications_none_outlined,
//                           size: 30,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const ImageSlider(),
//                   BlocBuilder<HomeBloc, HomeState>(
//                     builder: (context, state) {
//                       if (state is LoadingState) {
//                         return const Center(child: CircularProgressIndicator());
//                       }
//                       if (state is SuccessState) {
//                         final itemLayer = GetIt.I.get<ItemLayer>();
//                         final groupedItems =
//                             groupItemsByCategory(itemLayer.items);
//                         final selectedCategory = state.selectedCategory;
//                         final itemsToDisplay = selectedCategory == 'All'
//                             ? itemLayer.items
//                             : groupedItems[selectedCategory] ?? [];
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 16.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     const Text(
//                                       "Best Seller",
//                                       style: TextStyle(
//                                         fontFamily: "Average",
//                                         fontSize: 24,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 10),
//                                     Expanded(
//                                         child: Image.asset(
//                                             "assets/images/star_line.png"))
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               SizedBox(
//                                 height: 211,
//                                 child: ListView.builder(
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount: getBestSellers().length,
//                                   itemBuilder: (context, index) {
//                                     final item = getBestSellers()[index];
//                                     return Padding(
//                                       padding: const EdgeInsets.only(right: 10),
//                                       child: SizedBox(
//                                         width: 150,
//                                         child: ItemCard(item: item),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                               const SizedBox(height: 20),
//                               DefaultTabController(
//                                 length: itemLayer.categories.length,
//                                 child: TabBar(
//                                   onTap: (index) {
//                                     final category =
//                                         itemLayer.categories[index];
//                                     context.read<HomeBloc>().add(
//                                         ChangeCategoryEvent(
//                                             category: category));
//                                   },
//                                   isScrollable: true,
//                                   dividerColor: Colors.transparent,
//                                   indicatorColor: Colors.transparent,
//                                   tabs: itemLayer.categories.map((category) {
//                                     final isSelected =
//                                         selectedCategory == category;
//                                     return Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 5, horizontal: 10),
//                                       decoration: BoxDecoration(
//                                         color: isSelected
//                                             ? AppConstants.mainBlue
//                                             : Colors.white,
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       child: Text(
//                                         category,
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                           color: isSelected
//                                               ? AppConstants.mainBgColor
//                                               : Colors.black,
//                                         ),
//                                       ),
//                                     );
//                                   }).toList(),
//                                 ),
//                               ),
//                               GridView.builder(
//                                 shrinkWrap: true,
//                                 itemCount: itemsToDisplay.length,
//                                 itemBuilder: (context, index) {
//                                   final item = itemsToDisplay[index];
//                                   return ItemCard(
//                                       item: item,
//                                       onFav: () async {
//                                         log(item.name);
//                                         log(item.itemId);
//                                         log(GetIt.I
//                                             .get<AuthLayer>()
//                                             .customer!
//                                             .id);
//                                         final data = await GetIt.I
//                                             .get<SupabaseLayer>()
//                                             .supabase
//                                             .rpc('fav_item', params: {
//                                           'item_id': item.itemId,
//                                           'customer_id': GetIt.I
//                                               .get<AuthLayer>()
//                                               .customer
//                                               ?.id
//                                         });
//                                         print(data);
//                                       });
//                                 },
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 gridDelegate:
//                                     const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 2,
//                                   childAspectRatio: 1.69 / 2,
//                                   crossAxisSpacing: 10,
//                                   mainAxisSpacing: 10,
//                                 ),
//                               ),
//                               const SizedBox(height: 20),
//                             ],
//                           ),
//                         );
//                       }
//                       if (state is ErrorState) {
//                         log("error");
//                         return const Center(child: Text("Error loading items"));
//                       }
//                       return const SizedBox.shrink();
//                     },
//                   ),
//                   const SizedBox(height: 70),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// home_screen.dart
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/data_layers/auth_layer.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/helpers/helper.dart';
import 'package:project8/screens/user_screens/home/bloc/home_bloc.dart';
import 'package:project8/screens/user_screens/home/image_slider.dart';
import 'package:project8/widgets/cards/item_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppConstants.mainBgColor,
        body: SafeArea(
          child: SingleChildScrollView(
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
                const ImageSlider(),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is SuccessState) {
                      final itemLayer = GetIt.I.get<ItemLayer>();
                      final groupedItems = groupItemsByCategory(itemLayer.items);
                      final selectedCategory = state.selectedCategory;
                      final itemsToDisplay = selectedCategory == 'All'
                          ? itemLayer.items
                          : groupedItems[selectedCategory] ?? [];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Best Seller",
                                    style: TextStyle(
                                      fontFamily: "Average",
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: Image.asset(
                                          "assets/images/star_line.png"))
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 211,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: getBestSellers().length,
                                itemBuilder: (context, index) {
                                  final item = getBestSellers()[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: SizedBox(
                                      width: 150,
                                      child: ItemCard(item: item),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            DefaultTabController(
                              length: itemLayer.categories.length,
                              child: TabBar(
                                onTap: (index) {
                                  final category =
                                      itemLayer.categories[index];
                                  context.read<HomeBloc>().add(
                                      ChangeCategoryEvent(category: category));
                                },
                                isScrollable: true,
                                dividerColor: Colors.transparent,
                                indicatorColor: Colors.transparent,
                                tabs: itemLayer.categories
                                    .map((category) {
                                  final isSelected =
                                      selectedCategory == category;
                                  return Tab(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? AppConstants.mainBlue
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        category,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected
                                              ? AppConstants.mainBgColor
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              itemCount: itemsToDisplay.length,
                              itemBuilder: (context, index) {
                                final item = itemsToDisplay[index];
                                return ItemCard(item: item);
                              },
                              physics:
                                  const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.69 / 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      );
                    }
                    if (state is ErrorState) {
                      log("error");
                      return const Center(child: Text("Error loading items"));
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
