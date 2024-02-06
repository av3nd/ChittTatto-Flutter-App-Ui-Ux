import 'package:chitto_tatto/features/auth/domain/entity/user_entity.dart';
import 'package:chitto_tatto/features/food/data/model/food/food_api_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_api_model.g.dart';

final userApiModelProvider = Provider<UserApiModel>((ref) {
  return UserApiModel(
    userName: '',
    email: '',
    password: '',
    type: '',
    cart: [],
    image: '',
  );
});

@JsonSerializable()
class UserApiModel {
  @JsonKey(name: '_id')
  final String? userId;
  final String userName;
  final String email;
  final String password;
  final String? image;
  final String? type;
  final String? address;

  final List<FoodApiModel>? cart;

  UserApiModel(
      {this.image,
      this.type,
      this.userId,
      this.cart,
      this.address,
      required this.userName,
      required this.email,
      required this.password});

  factory UserApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);

  UserEntity toEntity() => UserEntity(
      userName: userName,
      email: email,
      password: password,
      image: image!,
      type: type!,
      userId: userId!,
      cart: cart!.map((e) => e.toEntity()).toList());

  // Convert AuthApiModel list to AuthEntity list
  List<UserEntity> listFromJson(List<UserApiModel> models) =>
      models.map((model) => model.toEntity()).toList();
  @override
  String toString() {
    return 'UserApiModel(userId: $userId, userName: $userName, email: $email, image: $image, type: $type, cart: $cart)';
  }
}
