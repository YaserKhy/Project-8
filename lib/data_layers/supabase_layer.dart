import 'package:get_it/get_it.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:project8/data_layers/auth_layer.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/helpers/helper.dart';
import 'package:project8/models/cart_item_model.dart';
import 'package:project8/models/customer_model.dart';
import 'package:project8/models/item_model.dart';
import 'package:project8/models/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseLayer {
  final supabase = Supabase.instance.client;

  Future createAccount(
      {required String email, required String password}) async {
    try {
      final AuthResponse response =
          await supabase.auth.signUp(email: email, password: password);
      return response;
    } catch (e) {
      return e;
    }
  }

  Future login(
      {required String email,
      required String password,
      required String externalId}) async {
    try {
      final AuthResponse response = await supabase.auth
          .signInWithPassword(email: email, password: password);

      OneSignal.login(externalId);
      await supabase.from('customer').update(
          {'notification_id': externalId}).eq('customer_id', response.user!.id);

      final temp = await supabase
          .from('customer')
          .select()
          .eq('customer_id', response.user!.id);
      GetIt.I.get<AuthLayer>().customer = CustomerModel.fromJson(temp.first);
      GetIt.I
          .get<AuthLayer>()
          .box
          .write('customer', GetIt.I.get<AuthLayer>().customer);
      return response;
    } catch (e) {
      return e;
    }
  }

  Future verifyOtp(
      {required String email,
      required String otp,
      required String name,
      required String role,
      required String phoneNumber,
      required String externalId}) async {
    try {
      final AuthResponse response = await supabase.auth
          .verifyOTP(email: email, token: otp, type: OtpType.email);
      final id = response.user!.id;
      OneSignal.Notifications.requestPermission(true);
      OneSignal.login(externalId);
      CustomerModel customer = CustomerModel.fromJson({
        'customer_id': id,
        'email': email,
        'name': name,
        'role': role,
        'phone_number': phoneNumber,
        'notification_id': externalId
      });
      await supabase.from("customer").insert(customer.toJson());
      GetIt.I.get<AuthLayer>().box.write('customer', customer.toJson());
      GetIt.I.get<AuthLayer>().customer = customer;
      return response;
    } catch (e) {
      return e;
    }
  }

  getAllItems() async {
    final itemsAsMap = await Supabase.instance.client.from("item").select();
    GetIt.I.get<ItemLayer>().items = itemsAsMap.map((item) {
      ItemModel newItem = ItemModel.fromJson(item);
      return newItem;
    }).toList();
  }

  addToFav({required String itemId}) async {
    await GetIt.I.get<SupabaseLayer>().supabase.rpc('fav_item', params: {
      'item_id': itemId,
      'customer_id': GetIt.I.get<AuthLayer>().customer?.id
    });
  }

  deleteFromFav({required String itemId}) async {
    await GetIt.I
        .get<SupabaseLayer>()
        .supabase
        .from('favorite')
        .delete()
        .match({
      'item_id': itemId,
      'customer_id': GetIt.I.get<AuthLayer>().customer!.id
    });
  }

  getFav() async {
    final List<ItemModel> favList = [];
    final List data = await supabase
        .rpc("get_fav", params: {"id": GetIt.I.get<AuthLayer>().customer?.id});
    for (Map<String, dynamic> element in data) {
      favList.add(ItemModel.fromJson(element));
    }
    GetIt.I.get<ItemLayer>().favItems = favList;
  }

  getCartItems() async {
    final List<CartItemModel> cartItems = [];
    final List data = await supabase.rpc("get_cart_items",
        params: {"customer_id": GetIt.I.get<AuthLayer>().customer?.id});
    for (Map<String, dynamic> element in data) {
      cartItems.add(CartItemModel.fromJson(element));
    }
    GetIt.I.get<ItemLayer>().cartItems = cartItems;
  }

  addCartItem({required String itemId, required int quantity}) async {
    bool alreadyAdded = false;
    getMatchingCartItems();
    for (var item in GetIt.I.get<ItemLayer>().matchingCartItems) {
      if (item.itemId == itemId) {
        try {
          alreadyAdded = true;
          await supabase.rpc("modify_item_quantity", params: {
            "customer_uuid": GetIt.I.get<AuthLayer>().customer!.id,
            "item_uuid": itemId,
            "new_quantity": item.quantity + quantity
          });
          getMatchingCartItems();
        } catch (e) {
          return e;
        }
      }
    }
    if (alreadyAdded == false) {
      try {
        await supabase.rpc("insert_to_cart", params: {
          "customer_uuid": GetIt.I.get<AuthLayer>().customer!.id,
          "item_uuid": itemId,
          "item_quantity": quantity,
          "sugar_preference": "asdf"
        });
      } catch (e) {
        return e;
      }
      getMatchingCartItems();
    }
  }

  deleteCartItem({required String itemId}) async {
    try {
      await supabase.rpc("delete_item_from_cart", params: {
        "customer_uuid": GetIt.I.get<AuthLayer>().customer!.id,
        "item_uuid": itemId
      });
    } catch (e) {
      return e;
    }
  }

  increaseItemQuantity({required String itemId, required int quantity}) async {
    try {
      await supabase.rpc("modify_item_quantity", params: {
        "customer_uuid": GetIt.I.get<AuthLayer>().customer!.id,
        "item_uuid": itemId,
        "new_quantity": ++quantity
      });
    } catch (e) {
      return e;
    }
  }

  decreaseItemQuantity({required String itemId, required int quantity}) async {
    try {
      await supabase.rpc("modify_item_quantity", params: {
        "customer_uuid": GetIt.I.get<AuthLayer>().customer!.id,
        "item_uuid": itemId,
        "new_quantity": --quantity
      });
    } catch (e) {
      return e;
    }
  }

  getOrders() async {
    GetIt.I.get<ItemLayer>().prevCarts.clear();
    List<OrderModel> temp = [];
    final data = await GetIt.I
        .get<SupabaseLayer>()
        .supabase
        .from('orders')
        .select()
        .eq('customer_id', GetIt.I.get<AuthLayer>().customer!.id);
    for (var order in data) {
      temp.add(OrderModel.fromJson(order));
      final res = await supabase
          .rpc('get_order_items', params: {'order_uuid': order['order_id']});
      GetIt.I.get<ItemLayer>().prevCarts.add(res);
    }
    GetIt.I.get<ItemLayer>().orders = temp;
  }

  employeeGetOrders() async {
    GetIt.I.get<ItemLayer>().prevCarts.clear();
    List<OrderModel> temp = [];
    final data =
        await GetIt.I.get<SupabaseLayer>().supabase.from('orders').select();
    for (var d in data) {
      temp.add(OrderModel.fromJson(d));
      final res = await supabase
          .rpc('get_order_items', params: {'order_uuid': d['order_id']});
      GetIt.I.get<ItemLayer>().prevCarts.add(res);
    }
    GetIt.I.get<ItemLayer>().orders = temp;
  }

  Stream employeeRealTimeGetOrders() {
    final stream = GetIt.I
        .get<SupabaseLayer>()
        .supabase
        .from('orders')
        .stream(primaryKey: ['order_id']);
    return stream;
  }

  addOrder(
      {required String cartId,
      required String pickupOrDelivery,
      String? address,
      required String paymentMethod,
      int? estimatedTime}) async {
    try {
      await supabase.from('orders').insert({
        'status': 'Waiting',
        'pickup_or_delivery': pickupOrDelivery,
        'address': address ?? 'undefined',
        'payment_method': paymentMethod,
        'estimated_time': estimatedTime ?? 1,
        'customer_id': GetIt.I.get<AuthLayer>().customer!.id,
        'cart_id': cartId
      });
      await supabase
          .from('cart')
          .update({'is_valid': false}).eq('cart_id', cartId);
      await getOrders();
    } catch (e) {
      return e;
    }
  }
}
