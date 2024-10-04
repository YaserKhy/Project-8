import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:project8/models/customer_model.dart';

class AuthLayer {
  CustomerModel? customer;
  final box = GetStorage();

  AuthLayer() {
    // box.erase();
    if (box.hasData('customer')) {
      log("wow");
      // print(box.read('customer'));
      log((customer?.toJson()).toString());
      Map<String, dynamic> customerAsMap = box.read('customer');
      log("readed as map");
      customer = CustomerModel.fromJson(customerAsMap);
      log("formjson ");
    }
  }

  bool isGuest() {
    if (!box.hasData('customer')) {
      return true;
    }
    return false;
  }
}
