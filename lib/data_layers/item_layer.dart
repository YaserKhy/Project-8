import 'package:get_storage/get_storage.dart';
import 'package:project8/models/cart_item_model.dart';
import 'package:project8/models/item_model.dart';
import 'package:project8/models/order_model.dart';

class ItemLayer {
  List<ItemModel> items = [];
  List<ItemModel> favItems = [];
  List<CartItemModel> cartItems = [];
  List<CartItemModel> matchingCartItems = [];
  List<OrderModel> orders = [];
  List<String> categories = [
    'All',
    "Cold Drinks",
    "Classic Drinks",
    "Drip Coffee",
    "Water"
  ];
  final box = GetStorage();
}
