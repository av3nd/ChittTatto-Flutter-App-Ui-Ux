import 'dart:io';

import 'package:chitto_tatto/core/failure/failure.dart';
import 'package:chitto_tatto/features/auth/data/data_source/local/auth_local_data_source.dart.dart';
import 'package:chitto_tatto/features/auth/domain/entity/user_entity.dart';
import 'package:chitto_tatto/features/auth/domain/repository/auth_domain_repository.dart';
import 'package:chitto_tatto/features/food/domain/entity/food_entity.dart';
import 'package:chitto_tatto/features/food/domain/entity/order_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authLocalRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthLocalRepository(
    ref.read(authLocalDataSourceProvider),
  );
});

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthLocalRepository(this._authLocalDataSource);

  @override
  Future<Either<Failure, bool>> loginUser(String email, String password) {
    return _authLocalDataSource.loginUser(email, password);
  }

  @override
  Future<Either<Failure, bool>> registerUser(UserEntity user) {
    return _authLocalDataSource.registerUser(user);
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> checkUser(String type) {
    // TODO: implement checkUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> deleteUser(String userId) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> updateUser(String id, UserEntity user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> getMe(String id) {
    // TODO: implement getMe
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> orderMe() {
    // TODO: implement orderMe
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> removeFromCart(String foodId) {
    // TODO: implement removeFromCart
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> saveUserAddress(String address) {
    // TODO: implement saveUserAddress
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<FoodEntity>>> addToCart(FoodEntity food) async {
    // TODO: implement addToCart
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<FoodEntity>>> getAllCart(String userId) {
    // TODO: implement getAllCart
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> getCurrentUserId() {
    // TODO: implement getCurrentUserId
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, OrderEntity>> createOrder(
      {required List<FoodEntity> cart,
      required double totalPrice,
      required String address}) {
    // TODO: implement createOrder
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> deleteOrder(String orderId) {
    // TODO: implement deleteOrder
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getAllOrders() {
    // TODO: implement getAllOrders
    throw UnimplementedError();
  }
}
