// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodApiModel _$FoodApiModelFromJson(Map<String, dynamic> json) => FoodApiModel(
      foodId: json['_id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String,
      quantity: json['quantity'] as int,
      category: json['category'] == null
          ? null
          : CategoryApiModel.fromJson(json['category'] as Map<String, dynamic>),
      price: json['price'] as int,
      image: json['image'] as String,
      rating: (json['rating'] as List<dynamic>?)
          ?.map((e) => RatingApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FoodApiModelToJson(FoodApiModel instance) =>
    <String, dynamic>{
      '_id': instance.foodId,
      'name': instance.name,
      'description': instance.description,
      'quantity': instance.quantity,
      'image': instance.image,
      'category': instance.category,
      'price': instance.price,
      'rating': instance.rating,
    };
