import 'dart:developer';
import 'package:get_it/get_it.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/data_layers/supabase_layer.dart';
import 'package:project8/models/item_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

getAllItems() async {
  final itemsAsMap = await Supabase.instance.client.from("item").select();
  GetIt.I.get<ItemLayer>().items = itemsAsMap.map((item) {
    ItemModel newItem = ItemModel.fromJson(item);
    return newItem;
  }).toList();
}

getOrderItems(String cartId) async {
  // {
  //   latte : 15
  //   coffe : 11
  //   etc....
  // }
  Map<String,dynamic> itemAndPrice = {};
  final itemsId = await GetIt.I.get<SupabaseLayer>().supabase.from("cart_item").select('item_id').eq('cart_id', cartId);
  log(itemsId.toString());
  for (var itemId in itemsId) {
    final itemData = await GetIt.I.get<SupabaseLayer>().supabase.from("item").select().eq('item_id', itemId['item_id']);
    final item = ItemModel.fromJson(itemData.first);
    itemAndPrice[item.name] = item.price;
  }
  return itemAndPrice;
}