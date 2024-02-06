import 'package:chitto_tatto/features/category/data/model/category_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../food/data/model/rating/rating_api_model.dart';

part 'category_food_model.g.dart';

@JsonSerializable()
class CategoryFoodModel {
  @JsonKey(name: '_id')
  final String name;
  final String description;
  final double quantity;
  final String image;
  final double price;
  final String? foodId;
  final List<RatingApiModel>? rating;
  final CategoryApiModel category;

  CategoryFoodModel({
    this.foodId,
    this.rating,
    required this.name,
    required this.description,
    required this.quantity,
    required this.image,
    required this.category,
    required this.price,
  });

  factory CategoryFoodModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryFoodModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryFoodModelToJson(this);
}
