import 'dart:io';

import 'package:chitto_tatto/core/failure/failure.dart';
import 'package:chitto_tatto/features/food/data/repository/food_remote_repo_impl.dart';
import 'package:chitto_tatto/features/food/domain/entity/food_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive_and_api_for_class/core/common/provider/internet_connectivity.dart';
// import 'package:hive_and_api_for_class/core/failure/failure.dart';
// import 'package:hive_and_api_for_class/features/auth/domain/entity/student_entity.dart';
// import 'package:hive_and_api_for_class/features/batch/data/repository/batch_local_repo_impl.dart';
// import 'package:hive_and_api_for_class/features/batch/data/repository/batch_remote_repo_impl.dart';
// import 'package:hive_and_api_for_class/features/batch/domain/entity/batch_entity.dart';

final foodRepositoryProvider = Provider<IFoodRepository>(
  (ref) {
    // // return ref.watch(batchLocalRepoProvider);
    // // // Check for the internet
    // final internetStatus = ref.watch(connectivityStatusProvider);

    // if (ConnectivityStatus.isConnected == internetStatus) {
    //   // If internet is available then return remote repo
    //   return ref.watch(foodRemoteRepoProvider);
    // } else {
    // If internet is not available then return local repo
    return ref.watch(foodRemoteRepositoryProvider);
    //   }
  },
);

abstract class IFoodRepository {
  Future<Either<Failure, List<FoodEntity>>> fetchAllFoods();
  // Future<Either<Failure, List<OrderEntity>>> fetchAllOrders();
  Future<Either<Failure, bool>> sellFood(FoodEntity food);
  // Future<Either<Failure, bool>> deleteFood(String foodId);
  // Future<Either<Failure, bool>> changeOrderStatus(String orderId);
  Future<Either<Failure, String>> uploadFoodPicture(File file);
  Future<Either<Failure, bool>> updateFood(String id, FoodEntity food);
  Future<Either<Failure, bool>> deleteFood(String id);
  Future<Either<Failure, List<FoodEntity>>> fetchFoodsByCategory(
      String categoryId);
  Future<Either<Failure, List<FoodEntity>>> searchFood(String name);
}
