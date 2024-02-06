// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_food_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryFoodModel _$CategoryFoodModelFromJson(Map<String, dynamic> json) =>
    CategoryFoodModel(
      foodId: json['foodId'] as String?,
      rating: (json['rating'] as List<dynamic>?)
          ?.map((e) => RatingApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['_id'] as String,
      description: json['description'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      image: json['image'] as String,
      category:
          CategoryApiModel.fromJson(json['category'] as Map<String, dynamic>),
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$CategoryFoodModelToJson(CategoryFoodModel instance) =>
    <String, dynamic>{
      '_id': instance.name,
      'description': instance.description,
      'quantity': instance.quantity,
      'image': instance.image,
      'price': instance.price,
      'foodId': instance.foodId,
      'rating': instance.rating,
      'category': instance.category,
    };
