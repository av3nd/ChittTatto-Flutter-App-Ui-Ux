import 'package:chitto_tatto/features/food/data/model/food/food_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_foods_by_category.g.dart';

@JsonSerializable()
class GetAllFoodsByCategoryDTO {
  final bool success;
  final String message;
  final List<FoodApiModel> data;

  GetAllFoodsByCategoryDTO({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetAllFoodsByCategoryDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllFoodsByCategoryDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllFoodsByCategoryDTOToJson(this);
}
