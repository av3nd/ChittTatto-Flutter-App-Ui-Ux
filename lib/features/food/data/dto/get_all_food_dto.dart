import 'package:chitto_tatto/features/food/data/model/food/food_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_food_dto.g.dart';

@JsonSerializable()
class GetAllFoodDTO {
  final bool success;
  final int count;
  final List<FoodApiModel> data;

  GetAllFoodDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllFoodDTOToJson(this);

  factory GetAllFoodDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllFoodDTOFromJson(json);
}
