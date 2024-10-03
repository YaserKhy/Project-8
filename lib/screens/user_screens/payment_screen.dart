// // import 'package:flutter/material.dart';
// // import 'package:moyasar/moyasar.dart';
// // import 'package:project8/extensions/screen_nav.dart';
// // import 'package:project8/screens/user_screens/order/orders_screen.dart';

// // class PaymentScreen extends StatelessWidget {
// //   final int price;
// //   const PaymentScreen({super.key, required this.price});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Container(
// //         padding: EdgeInsets.all(16),
// //         child: CreditCard(
// //             config: PaymentConfig(
// //               creditCard: CreditCardConfig(saveCard: true, manual: false),
// //               publishableApiKey:
// //                   'pk_test_d5DnML5zb2ZmVmg2w1whs6F5iQgVRHECCDDk3yFB',
// //               amount: price,
// //               description: 'order #1324',
// //             ),
// //             onPaymentResult: context.pushRemove(screen: const OrdersScreen())),
// //       ),
// //     );
// //   }
// // }


// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:moyasar/moyasar.dart';
// import 'package:project8/constants/app_constants.dart';

// class PaymentScreen extends StatelessWidget {
//   final int price;
//   const PaymentScreen({super.key, required this.price});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//       child: Scaffold(
//         backgroundColor: AppConstants.mainBgColor,
//         appBar: AppBar(
//               backgroundColor: AppConstants.mainBgColor,
//               centerTitle: true,
//               title: const Text("Cart",
//                   style: TextStyle(fontFamily: "Average", fontSize: 32)),
//             ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: CreditCard(
//                             config: PaymentConfig(
//                               creditCard: CreditCardConfig(saveCard: true, manual: false) ,
//                               publishableApiKey: dotenv.env['MOYASAR_KEY']!,
//                               amount: 50000,
//                               description: "description"
//                             ),
//                             onPaymentResult: (PaymentResponse result) {
//                               log("message yaaaaaaay");
//                             }
//                           ),
//         ),
//       ),
//     );
//   }
// }