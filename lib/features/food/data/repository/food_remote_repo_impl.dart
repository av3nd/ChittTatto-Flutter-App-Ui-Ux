import 'dart:io';

import 'package:chitto_tatto/core/failure/failure.dart';
import 'package:chitto_tatto/features/food/data/data_source/remote/food_remote_datasource.dart';
import 'package:chitto_tatto/features/food/domain/entity/food_entity.dart';
import 'package:chitto_tatto/features/food/domain/repository/food_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final foodRemoteRepositoryProvider = Provider<IFoodRepository>((ref) {
  return FoodRemoteRepository(
    ref.read(foodRemoteDataSourceProvider),
  );
});

class FoodRemoteRepository implements IFoodRepository {
  final FoodRemoteDataSource foodRemoteDataSource;

  FoodRemoteRepository(this.foodRemoteDataSource);

  @override
  Future<Either<Failure, bool>> sellFood(FoodEntity food) {
    // TODO: implement sellFood
    return foodRemoteDataSource.sellFood(food);
  }

  @override
  Future<Either<Failure, String>> uploadFoodPicture(File file) {
    // TODO: implement uploadProfilePicture
    return foodRemoteDataSource.uploadFoodPicture(file);
  }

  @override
  Future<Either<Failure, List<FoodEntity>>> fetchAllFoods() {
    // TODO: implement fetchAllFoods
    return foodRemoteDataSource.fetchAllFoods();
  }

  @override
  Future<Either<Failure, bool>> deleteFood(String foodId) {
    // TODO: implement deleteFood
    return foodRemoteDataSource.deleteFood(foodId);
  }

  @override
  Future<Either<Failure, bool>> updateFood(String id, FoodEntity food) {
    // TODO: implement updateFood
    return foodRemoteDataSource.updateFood(id, food);
  }

  @override
  Future<Either<Failure, List<FoodEntity>>> fetchFoodsByCategory(
      String categoryId) {
    // TODO: implement fetchFoodsByCategory
    return foodRemoteDataSource.fetchFoodsByCategory(categoryId);
  }

  @override
  Future<Either<Failure, List<FoodEntity>>> searchFood(String name) {
    // TODO: implement searchFood
    return foodRemoteDataSource.searchFood(name);
  }
}
