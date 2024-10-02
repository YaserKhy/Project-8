import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/data_layers/auth_layer.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/extensions/screen_nav.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/helpers/helper.dart';
import 'package:project8/screens/user_screens/cart/cart_screen.dart';
import 'package:project8/screens/user_screens/home/bloc/home_bloc.dart';
import 'package:project8/screens/user_screens/home/image_slider.dart';
import 'package:project8/screens/user_screens/view_item.dart';
import 'package:project8/widgets/cards/item_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project8/widgets/texts/category_title.dart';

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
                                child: Image.asset("assets/images/default_profile_img.png",fit: BoxFit.cover,),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Welcome Coffee Addict",
                                  style: TextStyle(fontFamily: "Average", fontSize: 16),
                                ),
                                Text(
                                  GetIt.I.get<AuthLayer>().customer!.name,
                                  style: const TextStyle(fontFamily: "Average",fontSize: 18,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: ()=>context.push(screen: const CartScreen()),
                          icon: const Icon(Icons.shopping_cart_outlined,size: 30),
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
                        final itemsToDisplay = selectedCategory == 'All' ? itemLayer.items : groupedItems[selectedCategory] ?? [];
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
                                  itemBuilder: (context, index) => ItemCard(
                                    item: getBestSellers()[index],
                                    onView: () => context.push(
                                      screen: ViewItem(item: getBestSellers()[index]),
                                      updateInfo:(p0){
                                        if(p0!=null) {
                                          bloc.add(GetAllItemsEvent());
                                        }
                                      }
                                    ),
                                  ),
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
                                      child: Row(
                                        children: [
                                          // const FaIcon(FontAwesomeIcons.mugHot),
                                          Icon(Icons.coffee, color: isSelected ? AppConstants.mainWhite : null),
                                          const SizedBox(width: 10,),
                                          Text(
                                            category,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: isSelected ? AppConstants.mainBgColor : Colors.black,
                                            ),
                                          ),
                                        ],
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
                                        itemCount: items!.length,
                                        itemBuilder: (context, index)=> ItemCard(
                                          item: items[index],
                                          onView: () => context.push(
                                            screen: ViewItem(item: items[index]),
                                            updateInfo:(p0){
                                              if(p0!=null) {
                                                bloc.add(GetAllItemsEvent());
                                              }
                                            }
                                          ),
                                        ),
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 1.69 / 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                        ),
                                      )
                                    ],
                                  );
                                }
                              )
                              // if specific category is selected
                              : GridView.builder(
                                itemCount: itemsToDisplay.length,
                                itemBuilder: (context, index)=> ItemCard(
                                  item: itemsToDisplay[index],
                                  onView: () => context.push(
                                    screen: ViewItem(item: itemsToDisplay[index]),
                                    updateInfo:(p0){
                                      if(p0!=null) {
                                        bloc.add(GetAllItemsEvent());
                                      }
                                    }
                                  ),
                                ),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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