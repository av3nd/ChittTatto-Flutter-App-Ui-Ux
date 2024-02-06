import 'package:chitto_tatto/core/failure/failure.dart';
import 'package:chitto_tatto/features/category/data/data_source/category_remote_data_source.dart';
import 'package:chitto_tatto/features/category/domain/entity/category_entity.dart';
import 'package:chitto_tatto/features/category/domain/repository/category_repository.dart';
import 'package:chitto_tatto/features/food/domain/entity/food_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRemoteRepoProvider = Provider<ICategoryRepository>(
  (ref) => CategoryRemoteRepositoryImpl(
    categoryRemoteDataSource: ref.read(categoryRemoteDataSourceProvider),
  ),
);

class CategoryRemoteRepositoryImpl implements ICategoryRepository {
  final CategoryRemoteDataSource categoryRemoteDataSource;

  CategoryRemoteRepositoryImpl({required this.categoryRemoteDataSource});

  @override
  Future<Either<Failure, bool>> addCategory(CategoryEntity category) {
    // TODO: implement addCategory
    // throw UnimplementedError();
    return categoryRemoteDataSource.addCategory(category);
  }

  @override
  Future<Either<Failure, bool>> deleteCategory(String id) {
    // TODO: implement deleteCategory
    return categoryRemoteDataSource.deleteCategory(id);
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() {
    // TODO: implement getAllCategories
    return categoryRemoteDataSource.getAllCategories();
  }

  @override
  Future<Either<Failure, List<FoodEntity>>> getAllFoodsByCategory(
      String categoryId) {
    // TODO: implement getAllFoodsByCategory
    return categoryRemoteDataSource.getAllFoodsByCategory(categoryId);
  }
}
