class CartItemModel {
  CartItemModel({
    required this.cartItemId,
    required this.itemId,
    required this.cartId,
    required this.quantity,
    required this.sugar,
  });
  late final String cartItemId;
  late final String itemId;
  late final String cartId;
  late final int quantity;
  late final String sugar;
  
  CartItemModel.fromJson(Map<String, dynamic> json){
    cartItemId = json['cart_item_id'];
    itemId = json['item_id'];
    cartId = json['cart_id'];
    quantity = json['quantity'];
    sugar = json['sugar'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cart_item_id'] = cartItemId;
    data['item_id'] = itemId;
    data['cart_id'] = cartId;
    data['quantity'] = quantity;
    data['sugar'] = sugar;
    return data;
  }
}