// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RatingHiveModelAdapter extends TypeAdapter<RatingHiveModel> {
  @override
  final int typeId = 3;

  @override
  RatingHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RatingHiveModel(
      userId: fields[0] as String?,
      rating: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, RatingHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RatingHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingHiveModel _$RatingHiveModelFromJson(Map<String, dynamic> json) =>
    RatingHiveModel(
      userId: json['userId'] as String?,
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$RatingHiveModelToJson(RatingHiveModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'rating': instance.rating,
    };
