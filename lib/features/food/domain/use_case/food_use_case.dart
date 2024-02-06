import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/food_entity.dart';
import '../repository/food_repository.dart';

final foodUseCaseProvider = Provider<FoodUseCase>(
  (ref) => FoodUseCase(
    foodRepository: ref.watch(foodRepositoryProvider),
  ),
);

class FoodUseCase {
  final IFoodRepository foodRepository;

  FoodUseCase({required this.foodRepository});

  Future<Either<Failure, bool>> sellFood(food) {
    return foodRepository.sellFood(food);
  }

  Future<Either<Failure, String>> uploadFoodPicture(File file) {
    return foodRepository.uploadFoodPicture(file);
  }

  Future<Either<Failure, List<FoodEntity>>> fetchAllFoods() {
    return foodRepository.fetchAllFoods();
  }

  Future<Either<Failure, bool>> deleteFood(String foodId) {
    return foodRepository.deleteFood(foodId);
  }

  Future<Either<Failure, bool>> updateFood(String id, FoodEntity food) {
    return foodRepository.updateFood(id, food);
  }

  Future<Either<Failure, List<FoodEntity>>> fetchFoodsByCategory(
      String categoryId) {
    return foodRepository.fetchFoodsByCategory(categoryId);
  }

  Future<Either<Failure, List<FoodEntity>>> searchFood(String name) {
    return foodRepository.searchFood(name);
  }
}
