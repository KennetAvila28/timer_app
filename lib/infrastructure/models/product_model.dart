import 'rating_model.dart';

class ProductModel{

  ProductModel({
  required this.id,
  required this.title,
  required this.price,
  required this.description,
  required this.category,
  required this.image,
  required this.rating,
  });

  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingModel rating;
  int quantity = 0;
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
  id: json["id"],
  title: json["title"],
  price: json["price"]?.toDouble(),
  description: json["description"],
  category: json["category"],
  image: json["image"],
  rating: RatingModel.fromJson(json["rating"]),
  );

  Map<String, dynamic> toJson() => {
  "id": id,
  "title": title,
  "price": price,
  "description": description,
  "category": category,
  "image": image,
  "rating": rating.toJson(),
  };

}