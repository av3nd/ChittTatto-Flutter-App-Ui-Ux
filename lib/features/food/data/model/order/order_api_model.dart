import 'package:chitto_tatto/features/food/data/model/food/food_api_model.dart';
import 'package:chitto_tatto/features/food/domain/entity/order_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_api_model.g.dart';

final orderApiModelProvider = Provider<OrderApiModel>((ref) {
  return const OrderApiModel(
      orderId: '',
      foods: [],
      address: '',
      quantity: [],
      userId: '',
      orderedAt: 0,
      price: 0,
      status: 0,
      totalPrice: 0.0);
});

@JsonSerializable()
class OrderApiModel {
  @JsonKey(name: '_id')
  final String? orderId;
  final List<FoodApiModel> foods;
  final List<int> quantity;
  final String address;
  final String userId;
  final int orderedAt;
  final int price;
  final int status;
  final double totalPrice;

  const OrderApiModel({
    this.orderId,
    required this.foods,
    required this.address,
    required this.quantity,
    required this.userId,
    required this.orderedAt,
    required this.status,
    required this.price,
    required this.totalPrice,
  });

  factory OrderApiModel.fromJson(Map<String, dynamic> json) =>
      _$OrderApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderApiModelToJson(this);

  // Convert API Object to Entity
  OrderEntity toEntity() => OrderEntity(
        orderId: orderId,
        foods: foods.map((e) => e.toEntity()).toList(),
        address: address,
        quantity: quantity,
        userId: userId,
        orderedAt: orderedAt,
        status: status,
        price: price,
        totalPrice: totalPrice,
      );

  // Convert API List to Entity List
  List<OrderEntity> toEntityList(List<OrderApiModel> models) =>
      models.map((model) => model.toEntity()).toList();
  List<OrderEntity> listFromJson(List<OrderApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'OrderApiModel(orderId: $orderId, foods: $foods, address: $address, quantity: $quantity, userId: $userId, orderedAt: $orderedAt, status: $order, price: $price, totalPrice: $totalPrice)';
  }
}
