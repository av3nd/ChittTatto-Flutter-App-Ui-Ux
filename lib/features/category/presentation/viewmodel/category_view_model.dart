import 'package:chitto_tatto/config/router/app_routes.dart';
import 'package:chitto_tatto/features/category/domain/entity/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/widgets/my_snackbar.dart';
import '../../domain/use_case/batch_use_case.dart';
import '../state/category_state.dart';

final categoryViewModelProvider =
    StateNotifierProvider<CategoryViewModel, CategoryState>(
  (ref) => CategoryViewModel(ref.watch(categoryUsecaseProvider)),
);

class CategoryViewModel extends StateNotifier<CategoryState> {
  final CategoryUseCase categoryUseCase;

  CategoryViewModel(this.categoryUseCase) : super(CategoryState.initial()) {
    getAllCategories();
  }

  Future<void> deleteCategory(
      BuildContext context, CategoryEntity category) async {
    state.copyWith(isLoading: true);
    var data = await categoryUseCase.deleteCategory(category.categoryId!);

    data.fold(
      (l) {
        showSnackBar(message: l.error, context: context, color: Colors.red);

        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state.categories.remove(category);
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(
          message: 'Category delete successfully',
          context: context,
        );
      },
    );
  }

  addCategory(CategoryEntity category) async {
    state.copyWith(isLoading: true);
    var data = await categoryUseCase.addCategory(category);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  getAllCategories() async {
    state = state.copyWith(isLoading: true);
    var data = await categoryUseCase.getAllCategories();
    state = state.copyWith(categories: []);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) =>
          state = state.copyWith(isLoading: false, categories: r, error: null),
    );
  }

  getAllFoodsByCategory(BuildContext context, String categoryId) async {
    state = state.copyWith(isLoading: true);
    var data = await categoryUseCase.getAllFoodsByCategory(categoryId);

    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
            message: failure.error, context: context, color: Colors.red);
      },
      (foods) {
        state = state.copyWith(isLoading: false, error: null, foods: foods);
        // final categoryName = state.categories
        // .firstWhere((category) => category.categoryId == categoryId)
        // .categoryName;
        Navigator.pushNamed(
          context,
          AppRoute.categoryFoodsRoute,
        );
      },
    );
  }

  getAllUserFoodsByCategory(BuildContext context, String categoryId) async {
    state = state.copyWith(isLoading: true);
    var data = await categoryUseCase.getAllFoodsByCategory(categoryId);

    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
            message: failure.error, context: context, color: Colors.red);
      },
      (foods) {
        state = state.copyWith(isLoading: false, error: null, foods: foods);
        // final categoryName = state.categories
        // .firstWhere((category) => category.categoryId == categoryId)
        // .categoryName;
        Navigator.pushNamed(
          context,
          AppRoute.userCategoryFoodsRoute,
        );
      },
    );
  }
}
