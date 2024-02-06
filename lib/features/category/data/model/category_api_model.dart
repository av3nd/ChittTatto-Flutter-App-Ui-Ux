import 'package:chitto_tatto/features/category/domain/entity/category_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_api_model.g.dart';

final categoryApiModelProvider = Provider<CategoryApiModel>(
  (ref) => const CategoryApiModel.empty(),
);

@JsonSerializable()
class CategoryApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? categoryId;
  final String categoryName;

  const CategoryApiModel({
    required this.categoryId,
    required this.categoryName,
  });
  const CategoryApiModel.empty()
      : categoryId = '',
        categoryName = '';

  Map<String, dynamic> toJson() => _$CategoryApiModelToJson(this);

  factory CategoryApiModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryApiModelFromJson(json);

  // Convert API Object to Entity
  CategoryEntity toEntity() => CategoryEntity(
        categoryId: categoryId,
        categoryName: categoryName,
      );

  // Convert Entity to API Object
  CategoryApiModel fromEntity(CategoryEntity entity) => CategoryApiModel(
        categoryId: entity.categoryId ?? '',
        categoryName: entity.categoryName,
      );

  // Convert API List to Entity List
  List<CategoryEntity> toEntityList(List<CategoryApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [categoryId, categoryName];
}
