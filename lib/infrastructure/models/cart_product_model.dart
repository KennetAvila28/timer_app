class CartProductModel {
  CartProductModel({
    required this.productId,
    required this.quantity,
  });

  final int productId;
  final int quantity;


  factory CartProductModel.fromJson(Map<String, dynamic> json) => CartProductModel(
    productId: json["productId"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "quantity": quantity,
  };
}