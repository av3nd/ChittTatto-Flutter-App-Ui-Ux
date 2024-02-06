import 'package:chitto_tatto/features/category/data/repository/category_local_repo_impl.dart';
import 'package:chitto_tatto/features/category/domain/entity/category_entity.dart';
import 'package:chitto_tatto/features/food/domain/entity/food_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/provider/internet_connectivity.dart';
import '../../../../core/failure/failure.dart';
import '../../data/repository/category_remote_repo_impl.dart';

final categoryRepositoryProvider = Provider<ICategoryRepository>(
  (ref) {
    // return ref.watch(batchLocalRepoProvider);
    // // Check for the internet
    final internetStatus = ref.watch(connectivityStatusProvider);

    if (ConnectivityStatus.isConnected == internetStatus) {
      // If internet is available then return remote repo
      return ref.watch(categoryRemoteRepoProvider);
    } else {
      // If internet is not available then return local repo
      return ref.watch(categoryLocalRepoProvider);
    }
  },
);

abstract class ICategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories();
  Future<Either<Failure, bool>> addCategory(CategoryEntity category);
  Future<Either<Failure, List<FoodEntity>>> getAllFoodsByCategory(
      String categoryId);
  Future<Either<Failure, bool>> deleteCategory(String id);
}
