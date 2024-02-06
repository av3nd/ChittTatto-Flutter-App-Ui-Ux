import 'package:chitto_tatto/features/category/data/model/category_api_model.dart';
import 'package:chitto_tatto/features/food/domain/entity/food_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../rating/rating_api_model.dart';

part 'food_api_model.g.dart';

final foodApiModelProvider = Provider<FoodApiModel>((ref) {
  return const FoodApiModel(
    foodId: '',
    name: '',
    description: '',
    quantity: 0,
    image: '',
    price: 0,
    rating: [],
  );
});

@JsonSerializable()
class FoodApiModel {
  @JsonKey(name: '_id')
  final String? foodId;
  final String name;
  final String description;
  final int quantity;
  final String image;
  final CategoryApiModel? category;
  final int price;

  final List<RatingApiModel>? rating;

  const FoodApiModel({
    this.foodId,
    required this.name,
    required this.description,
    required this.quantity,
    this.category,
    required this.price,
    required this.image,
    this.rating,
  });

  factory FoodApiModel.fromJson(Map<String, dynamic> json) =>
      _$FoodApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$FoodApiModelToJson(this);
  // Convert API Object to Entity
  FoodEntity toEntity() => FoodEntity(
        id: foodId,
        name: name,
        description: description,
        quantity: quantity,
        image: image,
        rating: rating?.map((e) => e.toEntity()).toList() ?? [],
        category: category?.toEntity(),
        price: price,
      );
  FoodApiModel fromEntity(FoodEntity entity) => FoodApiModel(
        foodId: entity.foodId,
        name: entity.name,
        image: entity.image!, // Updated conversion
        description: entity.description,
        quantity: entity.quantity,
        price: entity.price,
      );
  // Convert API List to Entity List
  List<FoodEntity> toEntityList(List<FoodApiModel> models) =>
      models.map((model) => model.toEntity()).toList();
  List<FoodEntity> listFromJson(List<FoodApiModel> models) =>
      models.map((model) => model.toEntity()).toList();
  // @override
  // List<Object?> get props => [foodId, name];
  @override
  String toString() {
    return 'UserApiModel(id: $foodId, name: $name, image:$image, description: $description, quantity: $quantity, price: $price)';
  }
}
