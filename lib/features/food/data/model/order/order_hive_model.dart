import 'package:chitto_tatto/config/constants/hive_table_constants.dart';
import 'package:chitto_tatto/features/category/data/model/category_hive_model.dart';
import 'package:chitto_tatto/features/food/data/model/food/food_hive_model.dart';
import 'package:chitto_tatto/features/food/domain/entity/order_entity.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'order_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.orderTableId)
class OrderHiveModel extends HiveObject {
  @HiveField(0)
  final String? orderId;

  @HiveField(1)
  final List<FoodHiveModel> foods;

  @HiveField(2)
  final List<int> quantity;

  @HiveField(3)
  final String address;

  @HiveField(4)
  final String userId;

  @HiveField(5)
  final int orderedAt;

  @HiveField(6)
  final int status;

  @HiveField(7)
  final int price;

  @HiveField(8)
  final double totalPrice;

  OrderHiveModel.empty()
      : this(
          orderId: '',
          foods: [],
          quantity: [],
          address: '',
          userId: '',
          orderedAt: 0,
          status: 0,
          price: 0,
          totalPrice: 0.0,
        );

  OrderHiveModel({
    String? orderId,
    required this.foods,
    required this.quantity,
    required this.address,
    required this.userId,
    required this.orderedAt,
    required this.status,
    required this.price,
    required this.totalPrice,
  }) : orderId = orderId ?? const Uuid().v4();

  OrderEntity toEntity() => OrderEntity(
      foods: FoodHiveModel.empty().toEntityList(foods),
      quantity: quantity,
      address: address,
      userId: userId,
      orderedAt: orderedAt,
      status: status,
      price: price,
      totalPrice: totalPrice);
  OrderHiveModel toHiveModel(OrderEntity? entity) {
    final List<FoodHiveModel> foodModels = entity!.foods
        .map(
          (food) => FoodHiveModel(
            // Convert the properties of the FoodEntity to FoodHiveModel
            foodId: food.foodId,
            name: food.name,
            description: food.description,
            quantity: food.quantity,
            category: CategoryHiveModel.empty(),
            price: food.price,
          ),
        )
        .toList();

    return OrderHiveModel(
      orderId: entity.orderId,
      foods: foodModels,
      quantity: entity.quantity,
      address: entity.address,
      userId: entity.userId,
      orderedAt: entity.orderedAt,
      status: entity.status,
      price: entity.price,
      totalPrice: entity.totalPrice,
    );
  }

  List<OrderEntity> toEntityList(List<OrderHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();
}
