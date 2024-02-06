import 'dart:io';

import 'package:chitto_tatto/features/auth/data/model/user_api_model.dart';
import 'package:chitto_tatto/features/food/data/model/food/food_api_model.dart';
import 'package:chitto_tatto/features/food/domain/entity/food_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/constants/api_endpoint.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/network/remote/http_service.dart';
import '../../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../../../category/domain/entity/category_entity.dart';

final foodRemoteDataSourceProvider = Provider(
  (ref) => FoodRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    foodApiModel: ref.read(foodApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
    userApiModel: ref.read(userApiModelProvider),
  ),
);

class FoodRemoteDataSource {
  final Dio dio;
  final FoodApiModel foodApiModel;
  final UserApiModel userApiModel;
  final UserSharedPrefs userSharedPrefs;

  FoodRemoteDataSource({
    required this.dio,
    required this.foodApiModel,
    required this.userSharedPrefs,
    required this.userApiModel,
  });

  Future<Either<Failure, bool>> sellFood(FoodEntity food) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold((l) => token = null, (r) => token = r!);
      Response response = await dio.post(
        ApiEndpoints.addFood,
        data: {
          "name": food.name,
          "description": food.description,
          "image": food.image,
          "quantity": food.quantity,
          "price": food.price,
          "category": food.category!.categoryId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, List<FoodEntity>>> fetchAllFoods() async {
    try {
      Response response = await dio.get(ApiEndpoints.fetchAllFoods);
      // print(response.data); // Verify the response data

      if (response.statusCode == 200) {
        List<FoodEntity> foods = [];

        // Iterate over the response data list
        for (var item in response.data) {
          FoodEntity food = FoodEntity(
            id: item["_id"],
            name: item["name"],
            description: item["description"],
            image: item["image"],
            quantity: item["quantity"],
            price: item["price"],
            category: CategoryEntity(
              categoryId: item["category"] ?? '',
              categoryName: item["category"] ?? '',
              // Other properties of CategoryEntity
            ),
          );
          foods.add(food);
        }

        return Right(foods);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  // Upload image using multipart
  Future<Either<Failure, String>> uploadFoodPicture(
    File image,
  ) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'foodPictures': await MultipartFile.fromFile(
            image.path,
            filename: fileName,
          ),
        },
      );

      Response response = await dio.post(
        ApiEndpoints.uploadFood,
        data: formData,
      );

      return Right(response.data["data"]);
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> deleteFood(String foodId) async {
    try {
      // Get the token from shared prefs
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.delete(
        ApiEndpoints.deleteFood + foodId,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> updateFood(String id, FoodEntity food) async {
    try {
      // Get the token from shared prefs
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.put(
        ApiEndpoints.updateFood + id,
        data: {
          "name": food.name,
          "description": food.description,
          "image": food.image,
          "quantity": food.quantity,
          "price": food.price,
          "category": food.category!.categoryId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, List<FoodEntity>>> fetchFoodsByCategory(
      String categoryId) async {
    try {
      // Make API call to fetch foods by category
      Response response =
          await dio.get(ApiEndpoints.getFoodsByCategory + categoryId);

      if (response.statusCode == 201) {
        List<FoodEntity> foods = [];

        // Iterate over the response data list
        for (var item in response.data['data']) {
          FoodEntity food = FoodEntity(
              id: item["_id"],
              name: item["name"],
              description: item["description"],
              image: item["image"],
              category: item["category"],
              quantity: item["quantity"],
              price: item["price"]
              // Add other properties as per the response structure
              );
          foods.add(food);
        }
        return Right(foods);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, List<FoodEntity>>> searchFood(String name) async {
    try {
      Response response = await dio.get(ApiEndpoints.searchFood + name);

      if (response.statusCode == 200) {
        // Parse the response data and convert to List<FoodEntity>
        List<dynamic> responseData = response.data;
        List<FoodEntity> foods = responseData
            .map((item) => FoodEntity(
                  id: item["_id"],
                  name: item["name"],
                  description: item["description"],
                  image: item["image"],
                  category: CategoryEntity(
                    categoryId: item["category"] ?? '',
                    categoryName: item["category"] ?? '',
                    // Add other properties of CategoryEntity as needed
                  ),
                  quantity: item["quantity"],
                  price: item["price"],
                  // Add other properties of FoodEntity as needed
                ))
            .toList();

        return Right(foods);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
