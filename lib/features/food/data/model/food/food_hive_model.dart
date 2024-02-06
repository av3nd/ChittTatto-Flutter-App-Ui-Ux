import 'package:chitto_tatto/config/constants/hive_table_constants.dart';
import 'package:chitto_tatto/features/category/data/model/category_hive_model.dart';
import 'package:chitto_tatto/features/food/data/model/rating/rating_hive_model.dart';
import 'package:chitto_tatto/features/food/domain/entity/food_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'food_hive_model.g.dart';

final foodHiveModelProvider = Provider(
  (ref) => FoodHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.foodTableId)
class FoodHiveModel extends HiveObject {
  @HiveField(0)
  final String? foodId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final int quantity;

  @HiveField(4)
  final CategoryHiveModel category;

  @HiveField(5)
  final int price;

  @HiveField(6)
  final List<RatingHiveModel>? rating;

  FoodHiveModel.empty()
      : this(
          foodId: '',
          name: '',
          description: '',
          quantity: 0,
          category: CategoryHiveModel.empty(),
          price: 0,
          rating: [],
        );

  FoodHiveModel({
    String? foodId,
    List<RatingHiveModel>? rating,
    required this.name,
    required this.description,
    required this.quantity,
    required this.category,
    required this.price,
  })  : foodId = foodId ?? const Uuid().v4(),
        rating = rating ?? [];

  FoodEntity toEntity() => FoodEntity(
        name: name,
        description: description,
        quantity: quantity,
        category: category.toEntity(),
        price: price,
        rating: RatingHiveModel.empty().toEntityList(rating!),
      );

  FoodHiveModel toHiveModel(FoodEntity entity) => FoodHiveModel(
        foodId: const Uuid().v4(),
        name: entity.name,
        description: entity.description,
        quantity: entity.quantity,
        category: CategoryHiveModel.empty().toHiveModel(entity.category!),
        price: entity.price,
        rating: RatingHiveModel.empty().toHiveModelList(entity.rating!),
      );

  List<FoodEntity> toEntityList(List<FoodHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'id: $foodId, name: $name, description: $description, quantity: $quantity, price: $price';
  }
}
