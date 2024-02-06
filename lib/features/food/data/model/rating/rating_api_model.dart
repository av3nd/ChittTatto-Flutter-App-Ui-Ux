import 'package:chitto_tatto/features/food/domain/entity/rating_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating_api_model.g.dart';

final ratingApiModelProvider = Provider<RatingApiModel>(
  (ref) => const RatingApiModel.empty(),
);

@JsonSerializable()
class RatingApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String userId;
  final double rating;

  const RatingApiModel({
    required this.userId,
    required this.rating,
  });
  const RatingApiModel.empty()
      : userId = '',
        rating = 0;

  Map<String, dynamic> toJson() => _$RatingApiModelToJson(this);

  factory RatingApiModel.fromJson(Map<String, dynamic> json) =>
      _$RatingApiModelFromJson(json);

  // Convert API Object to Entity
  RatingEntity toEntity() => RatingEntity(
        userId: userId,
        rating: rating,
      );

  // Convert Entity to API Object
  RatingApiModel fromEntity(RatingEntity entity) => RatingApiModel(
        userId: entity.userId,
        rating: entity.rating,
      );

  // Convert API List to Entity List
  List<RatingEntity> toEntityList(List<RatingApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [userId, rating];
}
