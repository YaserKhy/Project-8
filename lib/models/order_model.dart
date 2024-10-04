class OrderModel {
  final String orderId;
  String? orderDate;
  String? status;
  String? pickupOrDelivery;
  String? address;
  String? paymentMethod;
  String? estimatedTime;
  final String customerId;
  final String cartId;

  OrderModel({required this.orderId, this.orderDate, this.status, this.pickupOrDelivery, this.address, this.paymentMethod, this.estimatedTime, required this.customerId, required this.cartId});

  factory OrderModel.fromJson(Map<String,dynamic> json) {
    return OrderModel(
      orderId: json['order_id'],
      orderDate: json['order_date'] ?? DateTime.now(),
      status: json['status'] ?? 'Waiting',
      pickupOrDelivery : json['pickup_or_delivery'],
      address : json['address'] ?? 'undefined',
      paymentMethod : json['payment_method'] ?? 'cash',
      estimatedTime : json['estimated_time'] ?? 'undefined',
      customerId: json['customer_id'],
      cartId: json['cart_id']
    );
  }

  Map<String,dynamic> toJson() {
    return {
      'order_id' : orderId,
      'order_date' : orderDate,
      'status' : status,
      'pickup_or_delivery' : pickupOrDelivery,
      'address' : address,
      'payment_method' : paymentMethod,
      'estimated_time' : estimatedTime,
      'customer_id' : customerId,
      'cart_id' : cartId
    };
  }
}