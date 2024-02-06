import 'dart:io';

import 'package:chitto_tatto/core/failure/failure.dart';
import 'package:chitto_tatto/features/auth/data/repository/auth_remote_repository.dart';
import 'package:chitto_tatto/features/auth/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/provider/internet_connectivity.dart';
import '../../../food/domain/entity/food_entity.dart';
import '../../../food/domain/entity/order_entity.dart';
import '../../data/repository/auth_data_repository.dart';

final authRepositoryProvider = Provider<IAuthRepository>(
  (ref) {
    // return ref.watch(batchLocalRepoProvider);
    // // Check for the internet
    final internetStatus = ref.watch(connectivityStatusProvider);

    if (ConnectivityStatus.isConnected == internetStatus) {
      // If internet is available then return remote repo
      return ref.watch(authRemoteRepositoryProvider);
    } else {
      // If internet is not available then return local repo
      return ref.watch(authLocalRepositoryProvider);
    }
  },
);

abstract class IAuthRepository {
  Future<Either<Failure, bool>> registerUser(UserEntity user);
  Future<Either<Failure, bool>> loginUser(String email, String password);
  Future<Either<Failure, String>> uploadProfilePicture(File file);
  Future<Either<Failure, bool>> checkUser(String email);
  Future<Either<Failure, bool>> deleteUser(String userId);
  Future<Either<Failure, bool>> updateUser(String id, UserEntity user);
  Future<Either<Failure, UserEntity>> getMe(String id);
  Future<Either<Failure, List<UserEntity>>> getAllUsers();

  Future<Either<Failure, List<FoodEntity>>> addToCart(FoodEntity food);
  Future<Either<Failure, UserEntity>> removeFromCart(String foodId);
  Future<Either<Failure, UserEntity>> saveUserAddress(String address);
  Future<Either<Failure, List<OrderEntity>>> orderMe();
  Future<Either<Failure, List<FoodEntity>>> getAllCart(String userId);
  Future<Either<Failure, String>> getCurrentUserId();
  Future<Either<Failure, OrderEntity>> createOrder({
    required List<FoodEntity> cart,
    required double totalPrice,
    required String address,
  });
  Future<Either<Failure, bool>> deleteOrder(String orderId);
  Future<Either<Failure, List<OrderEntity>>> getAllOrders();
}
