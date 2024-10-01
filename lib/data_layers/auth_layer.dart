import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:project8/models/customer_model.dart';

class AuthLayer {
  CustomerModel? customer;
  final box = GetStorage();

  AuthLayer(){
    if(box.hasData('customer')) {
      log("wow");
      Map<String,dynamic> customerAsMap = box.read('customer');
      customer = CustomerModel.fromJson(customerAsMap);
    }
  }
}