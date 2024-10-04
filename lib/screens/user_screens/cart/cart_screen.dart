import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/data_layers/supabase_layer.dart';
import 'package:project8/extensions/screen_nav.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/helpers/helper.dart';
import 'package:project8/screens/user_screens/cart/bloc/cart_bloc.dart';
import 'package:project8/widgets/cards/cart_card.dart';
import 'package:moyasar/moyasar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc()..add(GetAllCartItemsEvent()),
      child: Builder(builder: (context) {
        final bloc = context.read<CartBloc>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstants.mainBgColor,
            centerTitle: true,
            title: const Text("Cart",
                style: TextStyle(fontFamily: "Average", fontSize: 32)),
          ),
          backgroundColor: AppConstants.mainBgColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  getMatchingCartItems();
                  if (state is LoadingState) {
                    return SizedBox(
                      height: context.getHeight(divideBy: 3),
                      child: Center(child: LottieBuilder.asset("assets/images/Animation - 1727608827461.json"))
                    );
                  }
                  if (state is ErrorState) {
                    log("error loading cart items");
                    return SizedBox(
                      height: context.getHeight(divideBy: 3),
                      child: const Center(child: Text("Error loading cart items"))
                    );
                  }
                  if (state is SuccessState) {
                    if (GetIt.I.get<ItemLayer>().matchingCartItems.isEmpty) {
                      return Center(
                        child: SizedBox(
                            height: context.getHeight(divideBy: 1.5),
                            child: Image.asset(
                              "assets/images/defult_empty.png",
                            )),
                      );
                    } else {
                      return Column(children: [
                        ...GetIt.I
                            .get<ItemLayer>()
                            .matchingCartItems
                            .map((item) => CartCard(
                                  cartItem: item,
                                  onDelete: () async {
                                    await GetIt.I
                                        .get<SupabaseLayer>()
                                        .deleteCartItem(itemId: item.itemId);
                                    bloc.add(GetAllCartItemsEvent());
                                  },
                                  onIncreaseQuantity: () async {
                                    final quantity = GetIt.I
                                        .get<ItemLayer>()
                                        .matchingCartItems
                                        .where((cartItem) =>
                                            cartItem.itemId == item.itemId)
                                        .first
                                        .quantity;
                                    if (quantity < 9) {
                                      await GetIt.I
                                          .get<SupabaseLayer>()
                                          .increaseItemQuantity(
                                              itemId: item.itemId,
                                              quantity: quantity);
                                      bloc.add(GetAllCartItemsEvent());
                                    }
                                  },
                                  onDecreaseQuantity: () async {
                                    final quantity = GetIt.I
                                        .get<ItemLayer>()
                                        .matchingCartItems
                                        .where((cartItem) =>
                                            cartItem.itemId == item.itemId)
                                        .first
                                        .quantity;
                                    if (quantity > 1) {
                                      await GetIt.I
                                          .get<SupabaseLayer>()
                                          .decreaseItemQuantity(
                                              itemId: item.itemId,
                                              quantity: quantity);
                                      bloc.add(GetAllCartItemsEvent());
                                    }
                                  },
                                )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              Image.asset('assets/images/red_stars2.png'),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  const Text("Total Price",
                                      style: TextStyle(fontSize: 20)),
                                  const Spacer(),
                                  Text(
                                    (state.cart?.totalPrice).toString(),
                                    style: const TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              SizedBox(
                                width: context.getHeight(divideBy: 1),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor:
                                          AppConstants.mainlightBlue,
                                      // fixedSize: const Size(350, 41)
                                    ),
                                    onPressed: ()=>log(GetIt.I.get<ItemLayer>().prevCarts.toString()),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Pay In Cash",
                                            style: TextStyle(
                                              color: Colors.white,
                                            )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        HugeIcon(
                                            icon:
                                                HugeIcons.strokeRoundedMoney03,
                                            color: Colors.white)
                                      ],
                                    )),
                              ),
                              SizedBox(
                                width: context.getHeight(divideBy: 1),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: AppConstants.mainRed,
                                    ),
                                    onPressed: () => showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            padding: const EdgeInsets.all(24),
                                            width: context.getWidth(),
                                            height: context.getHeight(
                                                divideBy: 1.5),
                                            decoration: BoxDecoration(
                                                color: AppConstants.mainBgColor,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Column(
                                              children: [
                                                const Text(
                                                  "Fill Card Info",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                CreditCard(
                                                    config: PaymentConfig(
                                                        creditCard:
                                                            CreditCardConfig(
                                                                saveCard: true,
                                                                manual: false),
                                                        publishableApiKey:
                                                            dotenv.env[
                                                                'MOYASAR_KEY']!,
                                                        amount: ((state.cart!
                                                                    .totalPrice *
                                                                100))
                                                            .toInt(),
                                                        description:
                                                            "description"),
                                                    onPaymentResult:
                                                        (PaymentResponse
                                                            result) async {
                                                      bloc.add(PayEvent(
                                                          cartId: GetIt.I.get<ItemLayer>().matchingCartItems.first.cartId,
                                                  paymentMethod: 'credit card',
                                                  pickupOrDelivery: 'pickup'));
                                                      context.pop();
                                                      context.pop();
                                                      log('here is orders');
                                                      log(GetIt.I
                                                          .get<ItemLayer>()
                                                          .orders
                                                          .length
                                                          .toString());
                                                    }),
                                              ],
                                            ),
                                          );
                                        }),
                                    child: const Text(
                                      "Pay Now",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset("assets/images/payment.png")
                                ],
                              )

                              // Padding(
                              //   padding: const EdgeInsets.all(16.0),
                              //   child: CreditCard(
                              //       config: PaymentConfig(
                              //           creditCard: CreditCardConfig(
                              //               saveCard: true, manual: false),
                              //           publishableApiKey: dotenv.env['MOYASAR_KEY']!,
                              //           amount: ((state.cart!.totalPrice*100)).toInt(),
                              //           description: "description"),
                              //       onPaymentResult: (PaymentResponse result) async {
                              //         bloc.add(PayEvent(cartId: GetIt.I.get<ItemLayer>().matchingCartItems.first.cartId));
                              //         context.pop();
                              //         log('here is orders');
                              //         log(GetIt.I.get<ItemLayer>().orders.length.toString());
                              //       }),
                              // ),
                            ],
                          ),
                        )
                      ]);
                    }
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}