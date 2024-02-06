// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_food_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllFoodDTO _$GetAllFoodDTOFromJson(Map<String, dynamic> json) =>
    GetAllFoodDTO(
      success: json['success'] as bool,
      count: json['count'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => FoodApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllFoodDTOToJson(GetAllFoodDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
