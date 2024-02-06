// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApiModel _$UserApiModelFromJson(Map<String, dynamic> json) => UserApiModel(
      image: json['image'] as String?,
      type: json['type'] as String?,
      userId: json['_id'] as String?,
      cart: (json['cart'] as List<dynamic>?)
          ?.map((e) => FoodApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      userName: json['userName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserApiModelToJson(UserApiModel instance) =>
    <String, dynamic>{
      '_id': instance.userId,
      'userName': instance.userName,
      'email': instance.email,
      'password': instance.password,
      'image': instance.image,
      'type': instance.type,
      'cart': instance.cart,
    };
