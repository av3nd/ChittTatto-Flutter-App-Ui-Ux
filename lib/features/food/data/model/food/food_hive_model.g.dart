// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoodHiveModelAdapter extends TypeAdapter<FoodHiveModel> {
  @override
  final int typeId = 2;

  @override
  FoodHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoodHiveModel(
      foodId: fields[0] as String?,
      rating: (fields[6] as List?)?.cast<RatingHiveModel>(),
      name: fields[1] as String,
      description: fields[2] as String,
      quantity: fields[3] as int,
      category: fields[4] as CategoryHiveModel,
      price: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FoodHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.foodId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
