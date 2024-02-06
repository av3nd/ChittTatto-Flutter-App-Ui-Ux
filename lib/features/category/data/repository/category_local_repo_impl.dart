import 'package:chitto_tatto/core/failure/failure.dart';
import 'package:chitto_tatto/features/category/data/data_source/category_local_data_source.dart';
import 'package:chitto_tatto/features/category/domain/entity/category_entity.dart';
import 'package:chitto_tatto/features/category/domain/repository/category_repository.dart';
import 'package:chitto_tatto/features/food/domain/entity/food_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryLocalRepoProvider = Provider<ICategoryRepository>((ref) {
  return CategoryLocalRepositoryImpl(
    categoryLocalDataSource: ref.read(categoryLocalDataSourceProvider),
  );
});

class CategoryLocalRepositoryImpl implements ICategoryRepository {
  final CategoryLocalDataSource categoryLocalDataSource;

  CategoryLocalRepositoryImpl({
    required this.categoryLocalDataSource,
  });

  @override
  Future<Either<Failure, bool>> addCategory(CategoryEntity category) {
    // TODO: implement addCategory
    return categoryLocalDataSource.addCategory(category);
  }

  @override
  Future<Either<Failure, bool>> deleteCategory(String id) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() {
    // TODO: implement getAllCategories
    // throw UnimplementedError();
    return categoryLocalDataSource.getAllCategories();
  }

  @override
  Future<Either<Failure, List<FoodEntity>>> getAllFoodsByCategory(
      String categoryId) {
    // TODO: implement getAllFoodsByCategory
    throw UnimplementedError();
  }
}
