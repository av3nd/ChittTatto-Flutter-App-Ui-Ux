import 'package:chitto_tatto/features/food/domain/entity/food_entity.dart';

class FoodState {
  final bool isLoading;
  final String? error;
  final String? imageName;
  final List<FoodEntity>? foods;

  const FoodState(
      {required this.isLoading,
      this.error,
      this.imageName,
      required this.foods});

  factory FoodState.initial() => const FoodState(
      isLoading: false, error: null, imageName: null, foods: []);

  FoodState copyWith(
      {bool? isLoading,
      String? error,
      String? imageName,
      List<FoodEntity>? foods}) {
    return FoodState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        imageName: imageName ?? this.imageName,
        foods: foods ?? this.foods);
  }

  @override
  String toString() => 'FoodState(isLoading: $isLoading, error: $error)';
}
