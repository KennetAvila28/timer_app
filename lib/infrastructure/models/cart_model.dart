import 'cart_product_model.dart';

class CartModel {
  CartModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  final int id;
  final int userId;
  final DateTime date;
  final List<CartProductModel> products;
  factory CartModel.fromEmpty()=>CartModel(id: 0, userId: 0, date: DateTime(Duration.hoursPerDay), products: []);
  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json["id"],
    userId: json["userId"],
    date: DateTime.parse(json["date"]),
    products: List<CartProductModel>.from(json["products"].map((x) => CartProductModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "date": date.toIso8601String(),
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

