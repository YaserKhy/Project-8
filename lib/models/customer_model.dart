class CustomerModel {
  final String id;
  final String email;
  final String name;
  final String phoneNumber;

  CustomerModel({required this.id, required this.email, required this.name, required this.phoneNumber});

  factory CustomerModel.fromJson(Map<String,dynamic> json) {
    return CustomerModel(id: json['customer_id'], name: json['name'], email: json['email'], phoneNumber: json['phone_number']);
  }

  Map<String,dynamic> toJson() {
    return {
      'customer_id' : id,
      'name' : name,
      'email' : email,
      'phone_number' : phoneNumber
    };
  }
}