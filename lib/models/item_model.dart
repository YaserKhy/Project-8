class ItemModel {
  ItemModel({
    required this.itemId,
    required this.name,
    required this.description,
    required this.category,
    required this.calories,
    required this.price,
    required this.image,
  });
  late final String itemId;
  late final String name;
  late final String description;
  late final String category;
  late final int calories;
  late final int price;
  late final String image;
  
  ItemModel.fromJson(Map<String, dynamic> json){
    itemId = json['item_id'];
    name = json['name'];
    description = json['description'];
    category = json['category'];
    calories = json['calories'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['item_id'] = itemId;
    data['name'] = name;
    data['description'] = description;
    data['category'] = category;
    data['calories'] = calories;
    data['price'] = price;
    data['image'] = image;
    return data;
  }
}