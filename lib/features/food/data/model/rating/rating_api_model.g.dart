// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingApiModel _$RatingApiModelFromJson(Map<String, dynamic> json) =>
    RatingApiModel(
      userId: json['_id'] as String,
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$RatingApiModelToJson(RatingApiModel instance) =>
    <String, dynamic>{
      '_id': instance.userId,
      'rating': instance.rating,
    };
