// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:chitto_tatto/config/router/app_routes.dart';
import 'package:chitto_tatto/core/common/widgets/my_snackbar.dart';
import 'package:chitto_tatto/features/auth/domain/entity/user_entity.dart';
import 'package:chitto_tatto/features/auth/domain/use_case/auth_usecase.dart';
import 'package:chitto_tatto/features/auth/presentation/state/auth_state.dart';
import 'package:chitto_tatto/features/food/domain/entity/food_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(ref.read(authUseCaseProvider), null
      // ref.read(userSharedPrefsProvider),
      );
});

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthUseCase _authUseCase;
  final String? imageName; // Add the imageName property

  AuthViewModel(this._authUseCase, this.imageName)
      : super(AuthState.initial()) {
    getAllUsers();
  }

  Future<void> uploadImage(File? file) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.uploadProfilePicture(file!);
    data.fold((l) {
      state = state.copyWith(isLoading: false, error: l.error);
    }, (imageName) {
      state = state.copyWith(isLoading: false, image: imageName);
    });
  }

  Future<void> registerUser(UserEntity user) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.registerUser(user);
    data.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (success) => state = state.copyWith(
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> getCurrentUserId() async {
    state = state.copyWith(isLoading: true);
    // Call the API using the AuthUseCase to get the current user's ID
    var data = await _authUseCase.getCurrentUserId();
    data.fold(
      (failure) {
        // Handle failure
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (userId) {
        // Handle success
        state = state.copyWith(isLoading: false, userId: userId, error: null);
      },
    );
  }

  Future<void> fetchCurrentUserIdIfLoggedIn() async {
    if (state.userId != null) {
      await getCurrentUserId();
    }
  }

  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    state = state.copyWith(isLoading: true);
    // bool isLogin = false;
    var data = await _authUseCase.loginUser(email, password);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
            context: context,
            color: Colors.red,
            message: "Invalid Credentials");
      },
      (success) async {
        state = state.copyWith(isLoading: false, error: null);

        checkUser(context, email);
        // Navigator.popAndPushNamed(context, AppRoute.adminBottomBarRoute);
        await getCurrentUserId();
        await fetchCurrentUser();

        await getAllCartForCurrentUser(state.userId!);
        await getAllOrders(context);
      },
    );
  }

  Future<void> checkUser(BuildContext context, String email) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.checkUser(email);

    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);

        showSnackBar(
          message: 'Invalid Credentials',
          context: context,
          color: Colors.red,
        );
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);

        Navigator.popAndPushNamed(context, AppRoute.bottomBarRoute);

        if (success == true) {
          Navigator.popAndPushNamed(context, AppRoute.adminBottomBarRoute);
        } else {
          Navigator.popAndPushNamed(context, AppRoute.bottomBarRoute);
        }
      },
    );
  }

  Future<void> updateUser(
      BuildContext context, String id, UserEntity user) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.updateUser(id, user);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
          message: failure.error,
          context: context,
          color: Colors.red,
        );
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(
          message: 'User updated successfully',
          context: context,
        );
      },
    );
  }

  Future<void> deleteUser(BuildContext context, String userId) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.deleteUser(userId);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
          message: failure.error,
          context: context,
          color: Colors.red,
        );
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(
          message: 'User deleted successfully',
          context: context,
        );
      },
    );
  }

  Future<void> getAllUsers() async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.getAllUsers();
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (users) {
        state = state.copyWith(isLoading: false, users: users, error: null);
      },
    );
  }

  Future<void> getAllCartForCurrentUser(String userId) async {
    state = state.copyWith(isLoading: true);

    // Fetch the current user's cart using the getAllCart method
    var result = await _authUseCase.getAllCart(userId);

    // Handle the result and update the state accordingly
    result.fold(
      (failure) {
        // Handle failure
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (cartData) {
        // Handle success

        state = state.copyWith(isLoading: false, cart: cartData, error: null);
      },
    );
  }

  // Sample function for adding a food item to the cart
  Future<void> addToCart(BuildContext context, FoodEntity food) async {
    state = state.copyWith(isLoading: true);

    // Perform any pre-processing or validations if required
    await fetchCurrentUserIdIfLoggedIn();
    // Call the API using the AuthRemoteDataSource
    final result = await _authUseCase.addToCart(food);

    // In the result, handle success and failure accordingly
    result.fold(
      (failure) {
        // Handle failure
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
          message: failure.error,
          context: context,
          color: Colors.red,
        );
      },
      (cart) async {
        // Handle success
        state = state.copyWith(isLoading: false, cart: cart, error: null);
        showSnackBar(
          message: 'Item added to cart',
          context: context,
        );

        // Call getAllCartForCurrentUser to update the cart list
      },
    );
  }

  Future<void> removeFromCart(BuildContext context, String foodId) async {
    // Perform any pre-processing or validations if required

    // Call the API using the AuthRemoteDataSource
    final result = await _authUseCase.removeFromCart(foodId);

    // In the result, handle success and failure accordingly
    result.fold(
      (failure) {
        // Handle failure
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
          message: failure.error,
          context: context,
          color: Colors.red,
        );
      },
      (isRemoved) {
        // Handle success
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(
          message: 'Item removed from cart',
          context: context,
        );
      },
    );
  }

  Future<void> saveUserAddress(BuildContext context, String address) async {
    // Perform any pre-processing or validations if required

    // Call the API using the AuthRemoteDataSource
    final result = await _authUseCase.saveUserAddress(address);

    // In the result, handle success and failure accordingly
    result.fold(
      (failure) {
        // Handle failure
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
          message: failure.error,
          context: context,
          color: Colors.red,
        );
      },
      (isSaved) {
        // Handle success
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(
          message: 'User address saved successfully',
          context: context,
        );
      },
    );
  }

  // Sample function for fetching user orders
  Future<void> getAllOrders(
    BuildContext context,
  ) async {
    // Call the API using the AuthRemoteDataSource
    final result = await _authUseCase.getAllOrders();

    // In the result, handle success and failure accordingly
    result.fold(
      (failure) {
        //     // Handle failure
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
          message: failure.error,
          context: context,
          color: Colors.red,
        );
      },
      (orders) {
        //     // Handle success and use the list of orders
        state = state.copyWith(isLoading: false, orders: orders, error: null);
        showSnackBar(
          message: 'User orders are here',
          context: context,
        );
      },
    );
  }

  Future<void> deleteOrder(BuildContext context, String orderId) async {
    state = state.copyWith(isLoading: true);

    // Call the API using the FoodUseCase to delete the food item
    var result = await _authUseCase.deleteOrder(orderId);

    result.fold(
      (failure) {
        // Handle failure
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
          message: failure.error,
          context: context,
          color: Colors.red,
        );
      },
      (isDeleted) {
        // Handle success
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(
          message: 'Food item deleted successfully',
          context: context,
        );
      },
    );
  }

  Future<void> fetchCurrentUser() async {
    if (state.userId != null) {
      state = state.copyWith(isLoading: true);
      var result = await _authUseCase.getMe(state.userId!);

      result.fold(
        (failure) {
          // Handle failure
          state = state.copyWith(isLoading: false, error: failure.error);
          // Show an error message to the user if needed
        },
        (user) {
          // Handle success
          state =
              state.copyWith(isLoading: false, currentUser: user, error: null);
        },
      );
    }
  }

  Future<void> createOrder({
    required List<FoodEntity> cart,
    required double totalPrice,
    required String address,
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true);

    var result = await _authUseCase.createOrder(
        cart: cart, totalPrice: totalPrice, address: address);

    result.fold(
      (failure) {
        // Handle failure
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
          message: failure.error,
          context: context,
          color: Colors.red,
        );
      },
      (order) {
        // Handle success
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(
          message: 'Order placed successfully',
          context: context,
        );

        // You can perform any additional actions after a successful order here, if needed.
      },
    );
  }
}
