import 'package:chitto_tatto/features/category/domain/entity/category_entity.dart';
import 'package:chitto_tatto/features/category/domain/repository/category_repository.dart';
import 'package:chitto_tatto/features/food/domain/entity/food_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';

final categoryUsecaseProvider = Provider<CategoryUseCase>(
  (ref) => CategoryUseCase(
    categoryRepository: ref.watch(categoryRepositoryProvider),
  ),
);

class CategoryUseCase {
  final ICategoryRepository categoryRepository;

  CategoryUseCase({required this.categoryRepository});

  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() {
    return categoryRepository.getAllCategories();
  }

  Future<Either<Failure, bool>> addCategory(CategoryEntity batch) {
    return categoryRepository.addCategory(batch);
  }

  Future<Either<Failure, bool>> deleteCategory(String categoryId) async {
    return categoryRepository.deleteCategory(categoryId);
  }

  Future<Either<Failure, List<FoodEntity>>> getAllFoodsByCategory(String id) {
    return categoryRepository.getAllFoodsByCategory(id);
  }
}
