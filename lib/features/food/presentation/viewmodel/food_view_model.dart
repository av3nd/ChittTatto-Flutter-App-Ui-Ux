// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:chitto_tatto/features/food/domain/entity/food_entity.dart';
import 'package:chitto_tatto/features/food/domain/use_case/food_use_case.dart';
import 'package:chitto_tatto/features/food/presentation/state/food_state.dart';
import 'package:chitto_tatto/features/home/presentation/widget/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/widgets/my_snackbar.dart';

final foodViewModelProvider = StateNotifierProvider<FoodViewModel, FoodState>(
  (ref) => FoodViewModel(ref.read(foodUseCaseProvider), null),
);

class FoodViewModel extends StateNotifier<FoodState> {
  final FoodUseCase foodUseCase;
  final String? imageName; // Add the imageName property
  FoodViewModel(this.foodUseCase, this.imageName) : super(FoodState.initial()) {
    fetchAllFoods();
  }

  // getAllCourses();

  Future<void> sellFood(BuildContext context, FoodEntity food) async {
    state = state.copyWith(isLoading: true);
    var data = await foodUseCase.sellFood(food);
    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showSnackBar(
            message: failure.error, context: context, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(
            message: "Successfully added a food for sale", context: context);
      },
    );
  }

  Future<void> uploadFoodImage(File? file) async {
    state = state.copyWith(isLoading: true);
    var data = await foodUseCase.uploadFoodPicture(file!);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (imageName) {
        state =
            state.copyWith(isLoading: false, error: null, imageName: imageName);
      },
    );
  }

  Future<void> fetchAllFoods() async {
    state = state.copyWith(isLoading: true);
    var data = await foodUseCase.fetchAllFoods();
    state = state.copyWith(foods: []);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, foods: r, error: null),
    );
  }

  Future<void> deleteFood(BuildContext context, FoodEntity food) async {
    state = state.copyWith(isLoading: true);
    var data = await foodUseCase.deleteFood(food.foodId ?? '');

    data.fold(
      (l) {
        showSnackBar(message: l.error, context: context, color: Colors.red);

        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state.foods!.remove(food);
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(
          message: 'Food deleted successfully',
          context: context,
        );
      },
    );
  }

  Future<void> searchFood(BuildContext context, String name) async {
    state = state.copyWith(isLoading: true);

    var data = await foodUseCase.searchFood(name);

    data.fold(
      // On failure case
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
          message: failure.error,
          context: context,
          color: Colors.red,
        );
        // You can choose to navigate to another page here on failure if needed.
        // For now, let's not navigate on failure.
      },
      // On success case
      (foods) {
        state = state.copyWith(isLoading: false, error: null);

        // Navigate to the SearchFoodPage passing the fetched 'foods' list
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchFoodPage(foods: foods),
          ),
        );
      },
    );
  }

  Future<void> updateFood(
      BuildContext context, String id, FoodEntity food) async {
    state = state.copyWith(isLoading: true);
    var data = await foodUseCase.updateFood(id, food);
    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showSnackBar(
          message: failure.error,
          context: context,
          color: Colors.red,
        );
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(
          message: 'Food updated successfully',
          context: context,
        );
      },
    );
  }
}
