import 'package:chitto_tatto/core/shared_prefs/user_shared_prefs.dart';
import 'package:chitto_tatto/features/category/data/dto/get_all_category_dto.dart';
import 'package:chitto_tatto/features/category/data/dto/get_all_foods_by_category.dart';
import 'package:chitto_tatto/features/category/data/model/category_api_model.dart';
import 'package:chitto_tatto/features/category/domain/entity/category_entity.dart';
import 'package:chitto_tatto/features/food/data/model/food/food_api_model.dart';
import 'package:chitto_tatto/features/food/domain/entity/food_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';

final categoryRemoteDataSourceProvider = Provider(
  (ref) => CategoryRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    categoryApiModel: ref.read(categoryApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
    foodApiModel: ref.read(foodApiModelProvider),
  ),
);

class CategoryRemoteDataSource {
  final Dio dio;
  final CategoryApiModel categoryApiModel;
  final FoodApiModel foodApiModel;
  final UserSharedPrefs userSharedPrefs;

  CategoryRemoteDataSource({
    required this.dio,
    required this.categoryApiModel,
    required this.foodApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> addCategory(CategoryEntity category) async {
    try {
      var response = await dio.post(
        ApiEndpoints.createCategory,
        data: categoryApiModel.fromEntity(category).toJson(),
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() async {
    try {
      var response = await dio.get(ApiEndpoints.getAllCategory);
      if (response.statusCode == 200) {
        // OR
        // 2nd way
        GetAllCategoryDTO categoryAddDTO =
            GetAllCategoryDTO.fromJson(response.data);
        return Right(categoryApiModel.toEntityList(categoryAddDTO.data));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  // Get all students by batchId
  Future<Either<Failure, List<FoodEntity>>> getAllFoodsByCategory(
      String categoryId) async {
    try {
      // get token
      String? token;
      await userSharedPrefs
          .getUserToken()
          .then((value) => value.fold((l) => null, (r) => token = r!));

      var response = await dio.get(ApiEndpoints.getFoodsByCategory + categoryId,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      if (response.statusCode == 201) {
        GetAllFoodsByCategoryDTO getAllFoodDTO =
            GetAllFoodsByCategoryDTO.fromJson(response.data);

        return Right(foodApiModel.listFromJson(getAllFoodDTO.data));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> deleteCategory(String categoryId) async {
    try {
      // Get the token from shared prefs
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.delete(
        ApiEndpoints.deleteCategory + categoryId,
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
}



//  // 1st way
//         var batches = (response.data['data'] as List)
//             .map((batch) => BatchApiModel.fromJson(batch).toEntity())
//             .toList();
//         return Right(batches);
