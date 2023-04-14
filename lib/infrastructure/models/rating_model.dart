class RatingModel {
  RatingModel({
    required this.rate,
    required this.count,
  });

  final double rate;
  final int count;

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
    rate: json["rate"]?.toDouble(),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "rate": rate,
    "count": count,
  };
}