import 'package:chitto_tatto/features/category/domain/entity/category_entity.dart';
import 'package:chitto_tatto/features/food/domain/entity/food_entity.dart';

class CategoryState {
  final bool isLoading;
  final List<CategoryEntity> categories;
  final List<FoodEntity>? foods;
  final String? error;
  final String? categoryName;

  CategoryState({
    this.foods,
    required this.isLoading,
    required this.categories,
    this.error,
    this.categoryName,
  });

  factory CategoryState.initial() {
    return CategoryState(
        isLoading: false, foods: [], categories: [], categoryName: '');
  }

  CategoryState copyWith({
    bool? isLoading,
    List<CategoryEntity>? categories,
    List<FoodEntity>? foods,
    String? error,
    String? categoryName,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      foods: foods ?? this.foods,
      error: error ?? this.error,
      categoryName: categoryName ?? this.categoryName,
    );
  }
}
