import 'package:chitto_tatto/features/category/data/model/category_hive_model.dart';
import 'package:chitto_tatto/features/category/domain/entity/category_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/network/local/hive_service.dart';

// Dependency Injection using Riverpod
final categoryLocalDataSourceProvider =
    Provider<CategoryLocalDataSource>((ref) {
  return CategoryLocalDataSource(
      hiveService: ref.read(hiveServiceProvider),
      categoryHiveModel: ref.read(categoryHiveModelProvider));
});

class CategoryLocalDataSource {
  final HiveServices hiveService;
  final CategoryHiveModel categoryHiveModel;

  CategoryLocalDataSource({
    required this.hiveService,
    required this.categoryHiveModel,
  });

  // Add Batch
  Future<Either<Failure, bool>> addCategory(CategoryEntity category) async {
    try {
      // Convert Entity to Hive Object
      final hiveCategory = categoryHiveModel.toHiveModel(category);
      // Add to Hive
      await hiveService.addCategory(hiveCategory);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() async {
    try {
      // Get all batches from Hive
      final categories = await hiveService.getAllCategories();
      // Convert Hive Object to Entity
      final categoryEntities = categoryHiveModel.toEntityList(categories);
      return Right(categoryEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
