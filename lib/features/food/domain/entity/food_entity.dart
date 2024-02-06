import 'package:chitto_tatto/features/category/domain/entity/category_entity.dart';
import 'package:chitto_tatto/features/food/domain/entity/rating_entity.dart';

class FoodEntity {
  final String? id;
  final String name;
  final String description;
  final int quantity;
  final String? image;
  final CategoryEntity? category;
  final int price;
  final List<RatingEntity>? rating;

  FoodEntity({
    required this.name,
    this.id,
    required this.description,
    required this.quantity,
    this.image,
    required this.category,
    required this.price,
    this.rating,
  });
  String? get foodId => id;
  factory FoodEntity.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? foodData =
        json['food'] as Map<String, dynamic>?;
    return FoodEntity(
      id: json['_id'] as String? ?? '',
      name: foodData?['name'] as String? ?? 'Unknown Food',
      description: foodData?['description'] as String? ?? 'No Description',
      image: foodData?['image'] as String?,
      category: json['category'] == null
          ? null
          : CategoryEntity.fromJson(json['category'] as Map<String, dynamic>),
      price: foodData?['price'] as int? ?? 0,
      quantity: foodData?['quantity'] as int? ?? 0,
      rating: json['rating'] != null
          ? List<RatingEntity>.from(
              json['rating'].map((x) => RatingEntity.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": foodId,
        "name": name,
        "description": description,
        "image": image,
        "category": category == null ? null : category!.toJson(),
        "rating": rating != null
            ? List<dynamic>.from(rating!.map((x) => x.toJson()))
            : null,
        "price": price,
      };
}
