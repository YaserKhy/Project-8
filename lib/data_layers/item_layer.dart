import 'package:get_storage/get_storage.dart';
import 'package:project8/models/cart_item_model.dart';
import 'package:project8/models/cart_model.dart';
import 'package:project8/models/item_model.dart';
import 'package:project8/models/order_model.dart';

class ItemLayer {
  // all items in the app
  List<ItemModel> items = [];

  // fav items by this user
  List<ItemModel> favItems = [];
  
  // this customer's cart
  CartModel? currentCart;

  // order and customer info
  Map<int,List<String>> orderInfo = {};

  // this customer's cart items
  List<CartItemModel> cartItems = [];

  // this customer's previous carts
  List<dynamic> prevCarts = [];

  // non-duplicated customer's cart
  List<CartItemModel> matchingCartItems = [];

  // this customer's orders
  List<OrderModel> orders = [];

  // ONZE categories
  List<String> categories = [
    'All',
    "Cold Drinks",
    "Classic Drinks",
    "Drip Coffee",
    "Water"
  ];

  // order statuses
  List<String> statuses = ['Waiting', "Preparing", "Ready", "Done"];

  final box = GetStorage();
}
