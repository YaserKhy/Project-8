class CartModel {
  CartModel({
    required this.cartId,
    required this.customerId,
    required this.totalPrice,
    required this.isValid,
  });
  late final String cartId;
  late final String customerId;
  late final num totalPrice;
  late final bool isValid;

  factory CartModel.fromJson(Map<String,dynamic> json) {
    return CartModel(cartId: json['cart_id'], customerId: json['customer_id'], totalPrice: json['total_price'], isValid: json['is_valid']);
  }

  Map<String, dynamic> toJson() {
    return {
      'cart_id' : cartId,
      'customer_id' : customerId,
      'total_price' : totalPrice,
      'is_valid' : isValid,
    };
  }
}