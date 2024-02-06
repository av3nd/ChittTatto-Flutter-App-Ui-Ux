import 'package:chitto_tatto/features/category/domain/entity/category_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/constants/hive_table_constants.dart';

part 'category_hive_model.g.dart';

final categoryHiveModelProvider = Provider(
  (ref) => CategoryHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.categoryTableId)
class CategoryHiveModel {
  @HiveField(0)
  final String categoryId;

  @HiveField(1)
  final String categoryName;

  // empty constructor
  CategoryHiveModel.empty() : this(categoryId: '', categoryName: '');

  CategoryHiveModel({
    String? categoryId,
    required this.categoryName,
  }) : categoryId = categoryId ?? const Uuid().v4();

  // Convert Hive Object to Entity
  CategoryEntity toEntity() => CategoryEntity(
        categoryId: categoryId,
        categoryName: categoryName,
      );

  // Convert Entity to Hive Object
  CategoryHiveModel toHiveModel(CategoryEntity entity) => CategoryHiveModel(
        // batchId: entity.batchId,
        categoryName: entity.categoryName,
      );

  // Convert Hive List to Entity List
  List<CategoryEntity> toEntityList(List<CategoryHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'categoryId: $categoryId, categoryName: $categoryName';
  }
}
