// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:chitto_tatto/config/constants/api_endpoint.dart';
import 'package:chitto_tatto/core/failure/failure.dart';
import 'package:chitto_tatto/core/network/remote/http_service.dart';
import 'package:chitto_tatto/core/shared_prefs/user_shared_prefs.dart';
import 'package:chitto_tatto/features/auth/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../food/domain/entity/food_entity.dart';
import '../../../../food/domain/entity/order_entity.dart';

final authRemoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class AuthRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  AuthRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> registerUser(UserEntity user) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.register,
        data: {
          "image": user.image,
          "userName": user.userName,
          "email": user.email,
          "password": user.password,
        },
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

  Future<Either<Failure, List<FoodEntity>>> getAllCart(String userId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.get(
        ApiEndpoints.getAllCart + userId,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Parse the response data and return a list of FoodEntity items
        List<dynamic> responseData = response.data["data"];
        print(responseData);
// List<FoodEntity> cartItems =
//     responseData.map((data) => FoodEntity.fromJson(data)).toList();

        List<FoodEntity> cart = [];

        // Iterate over the responseData list
        for (var item in responseData) {
          if (item is Map<String, dynamic>) {
            FoodEntity food = FoodEntity.fromJson(item);
            cart.add(food);
          }
        }

        return Right(cart);
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

  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    try {
      Response response = await dio.get(ApiEndpoints.getAllUsers);
      // print(response.data); // Verify the response data

      // Check if the response data is a Map
      if (response.data is Map<String, dynamic>) {
        // Access the 'data' property containing the list of users
        var responseData = response.data['data'];

        // Verify the responseData is a List<dynamic>
        if (responseData is List) {
          List<UserEntity> users = [];

          // Iterate over the responseData list
          for (var item in responseData) {
            if (item is Map<String, dynamic>) {
              UserEntity user = UserEntity.fromJson(item);
              users.add(user);
            }
          }

          return Right(users);
        }
      }

      return Left(
        Failure(
          error: "Invalid response data format",
          statusCode: response.statusCode.toString(),
        ),
      );
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> deleteUser(String userId) async {
    try {
      // Get the token from shared prefs
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.delete(
        ApiEndpoints.deleteUser + userId,
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

  Future<Either<Failure, bool>> updateUser(String id, UserEntity user) async {
    try {
      // Get the token from shared prefs
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.put(
        ApiEndpoints.updateUser + id,
        data: {
          "name": user.userName,
          "description": user.image,
          "image": user.email,
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

  Future<Either<Failure, String>> uploadProfilePicture(
    File image,
  ) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        'profilePicture':
            await MultipartFile.fromFile(image.path, filename: fileName)
      });
      Response response = await dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );
      return Right(response.data["data"]);
    } on DioException catch (e) {
      return Left(Failure(
        error: e.error.toString(),
        statusCode: e.response?.statusCode.toString() ?? '0',
      ));
    }
  }

  //Login
  Future<Either<Failure, bool>> loginUser(String email, String password) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        // retrieve token
        String token = response.data["token"];
        await userSharedPrefs.setUserToken(token);

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

  Future<Either<Failure, String>> getCurrentUserId() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.get(
        ApiEndpoints.getCurrentUserId,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Parse the response data and return the user ID
        String userId = response.data['userId'];
        return Right(userId);
      } else {
        return Left(
          Failure(
            error: response.data["error"],
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

  Future<Either<Failure, UserEntity>> getMe(String userId) async {
    try {
      Response response = await dio.get(ApiEndpoints.getMe + userId);

      if (response.statusCode == 200) {
        // Assuming the API response contains the 'user' object
        Map<String, dynamic> userData = response.data["user"];

        UserEntity user = UserEntity(
          userId: userData["_id"],
          userName: userData["name"],
          email: userData["description"],
          image: userData["image"],
          password: userData["quantity"],
          type: userData["type"],
          cart: (userData["cart"] as List)
              .map((item) => FoodEntity.fromJson(item["food"]))
              .toList(),
        );

        return Right(user);
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

  Future<Either<Failure, bool>> checkUser(String email) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.checkUser,
        data: {
          "email": email,
        },
      );
      if (response.statusCode == 201) {
        return const Right(true);
      } else if (response.statusCode == 200) {
        return const Right(false);
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

  Future<Either<Failure, List<FoodEntity>>> addToCart(FoodEntity food) async {
    try {
      // Get the token from shared prefs
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      // Convert the FoodEntity object to a map (JSON) representation
      Map<String, dynamic> foodData = food.toJson();

      // Map<String, dynamic> foodData = {
      //   "foodId": food.id!,
      //   "image": food.image,
      //   "name": food.name,
      //   "description": food.description,
      //   "price": food.price,
      //   "quantity": food.quantity,
      // };

      Response response = await dio.post(
        ApiEndpoints.addToCart,
        data: {
          'food': foodData, // Pass the entire food object
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Return the response data directly (List<FoodEntity>)
        return Right(response.data);
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

  // createOrder({
  //   required List<FoodEntity> cart,
  //   required double totalPrice,
  //   required String address,
  // }) async {
  //   try {
  //     String? token;
  //     var data = await userSharedPrefs.getUserToken();
  //     data.fold(
  //       (l) => token = null,
  //       (r) => token = r!,
  //     );

  //     List<Map<String, dynamic>> cartItems = cart.map((food) {
  //       return {
  //         'name': food.name, // Use 'foodId' directly from the 'FoodEntity'
  //         'quantity': food.quantity,
  //       };
  //     }).toList();

  //     final Map<String, dynamic> requestData = {
  //       'cart': cartItems,
  //       'totalPrice': totalPrice,
  //       'address': address,
  //     };

  //     final response = await dio.post(
  //       ApiEndpoints.order,
  //       data: requestData,
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //         },
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       // Order created successfully
  //       // You can perform any additional actions here if needed
  //     } else {
  //       // Handle the case when the server returns an error
  //       throw Exception(
  //           'Failed to create order. Server response: ${response.data}');
  //     }
  //   } on DioError catch (e) {
  //     print('Dio Error: ${e.message}');
  //     // Handle Dio errors (e.g., network error, timeout, etc.)
  //     throw Exception('Failed to create order. Dio Error: ${e.message}');
  //   } catch (e) {
  //     print('Error: $e');
  //     // Handle other types of errors
  //     throw Exception('Failed to create order. Error: $e');
  //   }
  // }

  Future<Either<Failure, OrderEntity>> createOrder({
    required List<FoodEntity> cart,
    required double totalPrice,
    required String address,
  }) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      List<Map<String, dynamic>> cartItems = cart.map((food) {
        return {'food': food};
      }).toList();

      final Map<String, dynamic> requestData = {
        'cart': cartItems,
        'totalPrice': totalPrice,
        'address': address,
      };

      final response = await dio.post(
        ApiEndpoints.order,
        data: requestData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Order created successfully
        // You can parse the response data and return the OrderEntity
        final orderEntity = OrderEntity.fromJson(response.data);
        return Right(orderEntity);
      } else {
        // Handle the case when the server returns an error
        return Left(Failure(
          error: response.data["message"],
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioError catch (e) {
      print('Dio Error: ${e.message}');
      // Handle Dio errors (e.g., network error, timeout, etc.)
      return Left(Failure(
        error: e.error.toString(),
        statusCode: e.response?.statusCode.toString() ?? '0',
      ));
    } catch (e) {
      print('Error: $e');
      // Handle other types of errors
      return Left(Failure(
        error: e.toString(),
        statusCode: '0',
      ));
    }
  }
  // Future<FoodEntity> getFoodById(String foodId) async {
  //   try {
  //     final response = await dio.get(ApiEndpoints.getFoodById + foodId);

  //     if (response.statusCode == 200) {
  //       return FoodEntity.fromJson(response.data['data']);
  //     } else {
  //       throw Exception('Failed to get food by ID');
  //     }
  //   } catch (e) {
  //     throw Exception('Network error: $e');
  //   }
  // }

  Future<Either<Failure, UserEntity>> removeFromCart(String foodId) async {
    try {
      // Get the token from shared prefs
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );
      // Send the foodId in the request parameters
      Response response = await dio.delete(
        ApiEndpoints.removeFromCart + foodId,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        // Parse the response data and return the updated user entity
        UserEntity user = UserEntity.fromJson(response.data);
        return Right(user);
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

  Future<Either<Failure, UserEntity>> saveUserAddress(String address) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );
      Response response = await dio.put(
        ApiEndpoints.saveUserAddress,
        data: {
          "address": address,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        UserEntity user = UserEntity.fromJson(response.data);
        return Right(user);
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

  Future<Either<Failure, List<OrderEntity>>> orderMe() async {
    try {
      // Get the token from shared prefs
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );
      // Send the request to fetch orders for the current user
      Response response = await dio.get(
        ApiEndpoints.orderMe,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        // Parse the response data and return a list of orders
        List<dynamic> responseData = response.data;
        List<OrderEntity> orders =
            responseData.map((data) => OrderEntity.fromJson(data)).toList();
        return Right(orders);
      } else {
        return Left(
          Failure(
            error: response.data["msg"] ?? "Failed to fetch orders",
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

  Future<Either<Failure, bool>> deleteOrder(String orderId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.delete(
        ApiEndpoints.deleteOrder + orderId,
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
            error: response.data["error"] ?? "Failed to delete order",
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

  Future<Either<Failure, List<OrderEntity>>> getAllOrders() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.get(
        ApiEndpoints.orderMe,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Parse the response data and return a list of OrderEntity items
        List<dynamic> responseData = response.data;
        List<OrderEntity> orders =
            responseData.map((data) => OrderEntity.fromJson(data)).toList();

        return Right(orders);
      } else {
        return Left(
          Failure(
            error: response.data["message"] ?? "Failed to fetch orders",
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
