// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_foods_by_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllFoodsByCategoryDTO _$GetAllFoodsByCategoryDTOFromJson(
        Map<String, dynamic> json) =>
    GetAllFoodsByCategoryDTO(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => FoodApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllFoodsByCategoryDTOToJson(
        GetAllFoodsByCategoryDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
