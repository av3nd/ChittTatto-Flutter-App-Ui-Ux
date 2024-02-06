import 'dart:io';

import 'package:chitto_tatto/core/failure/failure.dart';
import 'package:chitto_tatto/features/auth/domain/entity/user_entity.dart';
import 'package:chitto_tatto/features/auth/domain/repository/auth_domain_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../food/domain/entity/food_entity.dart';
import '../../../food/domain/entity/order_entity.dart';

final authUseCaseProvider = Provider((ref) {
  return AuthUseCase(
    ref.read(authRepositoryProvider),
  );
});

class AuthUseCase {
  final IAuthRepository _authRepository;
  AuthUseCase(this._authRepository);
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    return await _authRepository.uploadProfilePicture(file);
  }

  Future<Either<Failure, bool>> registerUser(UserEntity user) async {
    return await _authRepository.registerUser(user);
  }

  Future<Either<Failure, bool>> loginUser(String email, String password) async {
    return await _authRepository.loginUser(email, password);
  }

  Future<Either<Failure, bool>> checkUser(String email) async {
    return await _authRepository.checkUser(email);
  }

  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    return await _authRepository.getAllUsers();
  }

  Future<Either<Failure, bool>> deleteUser(String userId) async {
    return await _authRepository.deleteUser(userId);
  }

  Future<Either<Failure, bool>> updateUser(String id, UserEntity user) async {
    return await _authRepository.updateUser(id, user);
  }

  Future<Either<Failure, UserEntity>> getMe(String id) async {
    return await _authRepository.getMe(id);
  }

  Future<Either<Failure, List<FoodEntity>>> addToCart(FoodEntity food) async {
    return await _authRepository.addToCart(food);
  }

  Future<Either<Failure, UserEntity>> removeFromCart(String foodId) async {
    return await _authRepository.removeFromCart(foodId);
  }

  Future<Either<Failure, UserEntity>> saveUserAddress(String address) async {
    return await _authRepository.saveUserAddress(address);
  }

  Future<Either<Failure, List<OrderEntity>>> orderMe() async {
    return await _authRepository.orderMe();
  }

  Future<Either<Failure, List<FoodEntity>>> getAllCart(String userId) async {
    return await _authRepository.getAllCart(userId);
  }

  Future<Either<Failure, String>> getCurrentUserId() async {
    return await _authRepository.getCurrentUserId();
  }

  Future<Either<Failure, OrderEntity>> createOrder(
      {required List<FoodEntity> cart,
      required double totalPrice,
      required String address}) {
    return _authRepository.createOrder(
        cart: cart, totalPrice: totalPrice, address: address);
  }

  Future<Either<Failure, bool>> deleteOrder(String orderId) {
    return _authRepository.deleteOrder(orderId);
  }

  Future<Either<Failure, List<OrderEntity>>> getAllOrders() {
    return _authRepository.getAllOrders();
  }
}
