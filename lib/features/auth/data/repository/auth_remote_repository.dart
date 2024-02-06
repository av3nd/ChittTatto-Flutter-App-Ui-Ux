import 'dart:io';

import 'package:chitto_tatto/core/failure/failure.dart';
import 'package:chitto_tatto/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:chitto_tatto/features/auth/domain/entity/user_entity.dart';
import 'package:chitto_tatto/features/auth/domain/repository/auth_domain_repository.dart';
import 'package:chitto_tatto/features/food/domain/entity/food_entity.dart';
import 'package:chitto_tatto/features/food/domain/entity/order_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRemoteRepository(
    ref.read(authRemoteDataSourceProvider),
  );
});

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteRepository(this._authRemoteDataSource);
  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    return _authRemoteDataSource.uploadProfilePicture(file);
  }

  @override
  Future<Either<Failure, bool>> loginUser(String email, String password) {
    // TODO: implement loginStudent
    return _authRemoteDataSource.loginUser(email, password);
  }

  @override
  Future<Either<Failure, bool>> registerUser(UserEntity user) {
    // TODO: implement registerStudent
    return _authRemoteDataSource.registerUser(user);
  }

  @override
  Future<Either<Failure, bool>> checkUser(String email) {
    // TODO: implement checkUser
    return _authRemoteDataSource.checkUser(email);
  }

  @override
  Future<Either<Failure, bool>> deleteUser(String userId) {
    // TODO: implement deleteUser
    return _authRemoteDataSource.deleteUser(userId);
  }

  @override
  Future<Either<Failure, bool>> updateUser(String id, UserEntity user) {
    // TODO: implement updateUser
    return _authRemoteDataSource.updateUser(id, user);
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() {
    // TODO: implement getAllUsers
    return _authRemoteDataSource.getAllUsers();
  }

  @override
  Future<Either<Failure, UserEntity>> getMe(String id) {
    // TODO: implement getMe
    return _authRemoteDataSource.getMe(id);
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> orderMe() {
    // TODO: implement orderMe
    return _authRemoteDataSource.orderMe();
  }

  @override
  Future<Either<Failure, UserEntity>> removeFromCart(String foodId) {
    // TODO: implement removeFromCart
    return _authRemoteDataSource.removeFromCart(foodId);
  }

  @override
  Future<Either<Failure, UserEntity>> saveUserAddress(String address) {
    // TODO: implement saveUserAddress
    return _authRemoteDataSource.saveUserAddress(address);
  }

  @override
  Future<Either<Failure, List<FoodEntity>>> addToCart(FoodEntity food) async {
    // TODO: implement addToCart
    return _authRemoteDataSource.addToCart(food);
  }

  @override
  Future<Either<Failure, List<FoodEntity>>> getAllCart(String userId) {
    // TODO: implement getAllCart
    return _authRemoteDataSource.getAllCart(userId);
  }

  @override
  Future<Either<Failure, String>> getCurrentUserId() {
    // TODO: implement getCurrentUserId
    return _authRemoteDataSource.getCurrentUserId();
  }

  @override
  Future<Either<Failure, OrderEntity>> createOrder(
      {required List<FoodEntity> cart,
      required double totalPrice,
      required String address}) {
    // TODO: implement createOrder
    return _authRemoteDataSource.createOrder(
        cart: cart, totalPrice: totalPrice, address: address);
  }

  @override
  Future<Either<Failure, bool>> deleteOrder(String orderId) {
    // TODO: implement deleteOrder
    return _authRemoteDataSource.deleteOrder(orderId);
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getAllOrders() {
    // TODO: implement getAllOrders
    return _authRemoteDataSource.getAllOrders();
  }
}
