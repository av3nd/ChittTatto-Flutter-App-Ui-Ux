import 'package:chitto_tatto/features/auth/domain/entity/user_entity.dart';

import '../../../food/domain/entity/food_entity.dart';
import '../../../food/domain/entity/order_entity.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final String? image;
  final List<UserEntity> users;
  final List<FoodEntity> cart;
  final String address;
  final String? userId;
  final List<OrderEntity> orders;
  final UserEntity?
      currentUser; // Add the currentUser property// Add the orders property

  AuthState({
    required this.isLoading,
    this.error,
    this.image,
    required this.users,
    required this.cart,
    required this.address,
    this.userId,
    required this.orders,
    this.currentUser, // Initialize the currentUser property // Initialize the orders property
  });

  factory AuthState.initial() {
    return AuthState(
      isLoading: false,
      error: null,
      image: null,
      users: [],
      cart: [],
      address: '',
      userId: null,
      orders: [],
      currentUser: null, // Initialize currentUser to null initially
    );
  }

  AuthState copyWith({
    bool? isLoading,
    String? error,
    String? image,
    List<UserEntity>? users,
    UserEntity? currentUser,
    List<FoodEntity>? cart,
    String? address,
    String? userId,
    List<OrderEntity>? orders, // Include the orders property in copyWith
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      image: image ?? this.image,
      users: users ?? this.users,
      cart: cart ?? this.cart,
      address: address ?? this.address,
      userId: userId ?? this.userId,
      orders: orders ?? this.orders,
      currentUser:
          currentUser ?? this.currentUser, // Update currentUser in copyWith
    );
  }

  @override
  String toString() =>
      'AuthState(isLoading: $isLoading, error: $error, cart: $cart, address: $address, orders: $orders)';
}
