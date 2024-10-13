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
            title: const Text("Cart",style: TextStyle(fontFamily: "Average", fontSize: 32)),
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
                    return SizedBox(
                      height: context.getHeight(divideBy: 3),
                      child: Center(child: Text(state.msg))
                    );
                  }
                  if (state is SuccessState || state is ToggleDeliveryState) {
                    bool isDelivery = (state is ToggleDeliveryState) ? state.isDelivery : bloc.isDelivery;
                    if (GetIt.I.get<ItemLayer>().matchingCartItems.isEmpty) {
                      return Center(
                        child: SizedBox(
                          height: context.getHeight(divideBy: 1.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                width: context.getWidth(),
                                height: context.getHeight(divideBy: 2),
                                "assets/images/defult_empty.png",
                              ),
                              const SizedBox(height: 10,),
                              const Text("What are you waiting for ?\nAdd items to your cart now.",style: TextStyle(fontSize: 20),)
                            ],
                          )
                        ),
                      );
                    }
                    else {
                      return Column(
                        children: [
                          ...GetIt.I.get<ItemLayer>().matchingCartItems.map(
                            (item) => CartCard(
                              cartItem: item,
                              onDelete: () async {
                                await GetIt.I.get<SupabaseLayer>().deleteCartItem(itemId: item.itemId);
                                bloc.add(GetAllCartItemsEvent());
                              },
                              onIncreaseQuantity: () async {
                                final quantity = GetIt.I.get<ItemLayer>().matchingCartItems.where((cartItem) =>cartItem.itemId == item.itemId).first.quantity;
                                if (quantity < 9) {
                                  await GetIt.I.get<SupabaseLayer>().increaseItemQuantity(itemId: item.itemId,quantity: quantity);
                                  bloc.add(GetAllCartItemsEvent());
                                }
                              },
                              onDecreaseQuantity: () async {
                                final quantity = GetIt.I.get<ItemLayer>().matchingCartItems.where((cartItem) =>cartItem.itemId == item.itemId).first.quantity;
                                if (quantity > 1) {
                                  await GetIt.I.get<SupabaseLayer>().decreaseItemQuantity(itemId: item.itemId,quantity: quantity);
                                  bloc.add(GetAllCartItemsEvent());
                                }
                              },
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                Image.asset('assets/images/red_stars2.png'),
                                const SizedBox(height: 16,),
                                Row(
                                  children: [
                                    const Text("Total Price",style: TextStyle(fontSize: 20)),
                                    const Spacer(),
                                    Text(
                                      '${GetIt.I.get<ItemLayer>().currentCart?.totalPrice} SR',
                                      style: const TextStyle(fontSize: 20),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                Row(
                                  children: [
                                    const Text("Delivery"),
                                    const Spacer(),
                                    Checkbox(
                                      value: bloc.isDelivery,
                                      fillColor: WidgetStatePropertyAll(bloc.isDelivery ? AppConstants.mainBlue : WidgetStateColor.transparent),
                                      checkColor: AppConstants.mainWhite,
                                      onChanged: (v)=>{bloc.add(ToggleDeliveryEvent())},
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                isDelivery ? TextFormField(
                                  autovalidateMode: AutovalidateMode.onUnfocus,
                                  controller: bloc.addressController,
                                  validator: (value) {
                                    if(bloc.addressController.text.isEmpty) {
                                      return "Address is required in delivery case";
                                    }
                                    return null;
                                  },
                                  maxLength: 50,
                                  onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),),
                                    hintText: "Enter your address",
                                    counterText: '',
                                    filled: true,
                                    fillColor: AppConstants.mainWhite
                                  ),
                                ) : const SizedBox.shrink(),
                                const SizedBox(height: 20,),
                                SizedBox(
                                  width: context.getHeight(divideBy: 1),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5)),
                                      backgroundColor:AppConstants.mainlightBlue,
                                    ),
                                    onPressed: (){
                                      bloc.add(PayEvent(
                                        cartId: GetIt.I.get<ItemLayer>().matchingCartItems.first.cartId,
                                        paymentMethod: 'cash',
                                        pickupOrDelivery: bloc.isDelivery ? 'delivery' : 'pickup'
                                      ));
                                      context.pop();
                                      showDialog(context: context, builder: (context)=>const AlertDialog(
                                        content: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 50),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.check_circle_outline, color: Colors.green,size: 35,),
                                                Text("Thank you for ordering !"),
                                              ],
                                            ),
                                          ),
                                        )
                                      );
                                    },
                                    child: const Row(
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      children: [
                                        Text("Pay In Cash",style: TextStyle(color: Colors.white,)),
                                        SizedBox(width: 5,),
                                        HugeIcon(icon: HugeIcons.strokeRoundedMoney03,color: Colors.white)
                                      ],
                                    )
                                  ),
                                ),
                                SizedBox(
                                  width: context.getHeight(divideBy: 1),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                      backgroundColor: AppConstants.mainRed,
                                    ),
                                    onPressed: () => showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) {
                                        return Container(
                                          padding: const EdgeInsets.all(24),
                                          width: context.getWidth(),
                                          height: context.getHeight(divideBy: 1.35),
                                          decoration: const BoxDecoration(
                                            color: AppConstants.mainBgColor,
                                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                          ),
                                          child: Column(
                                            children: [
                                              const Text("Fill Card Info", style: TextStyle(fontSize: 20)),
                                              Theme(
                                                data: ThemeData(textTheme: const TextTheme()),
                                                child: CreditCard(
                                                  config: PaymentConfig(
                                                    creditCard: CreditCardConfig(saveCard: false, manual: false),
                                                    publishableApiKey: dotenv.env['MOYASAR_KEY']!,
                                                    amount: ((GetIt.I.get<ItemLayer>().currentCart!.totalPrice * 100)).toInt(),
                                                    description: "description",
                                                  ),
                                                  onPaymentResult: (PaymentResponse result) async {
                                                    bloc.add(PayEvent(
                                                      cartId: GetIt.I.get<ItemLayer>().matchingCartItems.first.cartId,
                                                      paymentMethod: 'credit card',
                                                      pickupOrDelivery: bloc.isDelivery ? 'delivery' : 'pickup',
                                                    ));
                                                    context.pop();
                                                    context.pop();
                                                    showDialog(context: context, builder: (context)=>const AlertDialog(
                                                      content: Padding(
                                                        padding: EdgeInsets.symmetric(vertical: 50),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Icon(Icons.check_circle_outline, color: Colors.green,size: 35,),
                                                            Text("Thank you for ordering !"),
                                                          ],
                                                        ),
                                                      ),
                                                    ));
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    ),
                                    child: const Text("Pay Now",style: TextStyle(color: Colors.white))
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [Image.asset("assets/images/payment.png")],
                                )
                              ],
                            ),
                          )
                        ]
                      );
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