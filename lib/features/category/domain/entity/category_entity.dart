import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String? categoryId;
  final String categoryName;

  const CategoryEntity({
    this.categoryId,
    required this.categoryName,
  });

  factory CategoryEntity.fromJson(Map<String, dynamic> json) => CategoryEntity(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
      };

  @override
  List<Object?> get props => [categoryId, categoryName];
}
