import 'package:get_storage/get_storage.dart';
import 'package:project8/models/item_model.dart';

class ItemLayer {
  List<ItemModel> items = [];
  List<ItemModel> favItems = [];
  List<String> categories = ['All',"Classic Drinks","Cold Drinks","Drip Coffee","Water"];
  final box = GetStorage();
}