import 'package:chitto_tatto/config/constants/hive_table_constants.dart';
import 'package:chitto_tatto/features/food/domain/entity/rating_entity.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'rating_hive_model.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTableConstant.ratingTableId)
class RatingHiveModel extends HiveObject {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final double rating;

  RatingHiveModel.empty() : this(userId: '', rating: 0.0);

  RatingHiveModel({
    String? userId,
    required this.rating,
  }) : userId = userId ?? const Uuid().v4();

  // Convert Hive Object to Entity
  RatingEntity toEntity() => RatingEntity(
        userId: userId,
        rating: rating,
      );

  // Convert Entity to Hive Object
  RatingHiveModel toHiveModel(RatingEntity entity) => RatingHiveModel(
        // batchId: entity.batchId,
        rating: entity.rating,
      );
  List<RatingHiveModel> toHiveModelList(List<RatingEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();
  // Convert Hive List to Entity List
  List<RatingEntity> toEntityList(List<RatingHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'userId: $userId, rating: $rating';
  }
}
