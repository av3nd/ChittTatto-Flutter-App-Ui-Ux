// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderApiModel _$OrderApiModelFromJson(Map<String, dynamic> json) =>
    OrderApiModel(
      orderId: json['_id'] as String?,
      foods: (json['foods'] as List<dynamic>)
          .map((e) => FoodApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      address: json['address'] as String,
      quantity:
          (json['quantity'] as List<dynamic>).map((e) => e as int).toList(),
      userId: json['userId'] as String,
      orderedAt: json['orderedAt'] as int,
      status: json['status'] as int,
      price: json['price'] as int,
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderApiModelToJson(OrderApiModel instance) =>
    <String, dynamic>{
      '_id': instance.orderId,
      'foods': instance.foods,
      'quantity': instance.quantity,
      'address': instance.address,
      'userId': instance.userId,
      'orderedAt': instance.orderedAt,
      'price': instance.price,
      'status': instance.status,
      'totalPrice': instance.totalPrice,
    };
