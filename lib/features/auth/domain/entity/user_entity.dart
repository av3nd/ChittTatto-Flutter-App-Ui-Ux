import '../../../food/domain/entity/food_entity.dart';

class UserEntity {
  final String? userId;
  final String? image;
  final String? type;
  final String? address;

  final String userName;
  final String email;
  final String password;
  final List<FoodEntity>? cart;

  UserEntity({
    this.userId,
    this.address,
    this.image,
    this.type,
    required this.userName,
    required this.email,
    required this.password,
    this.cart,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    List<dynamic>? cartData = json['cart'];
    List<FoodEntity>? cart =
        cartData?.map((item) => FoodEntity.fromJson(item)).toList();
    return UserEntity(
        userId: json['_id'],
        image: json['image'],
        address: json['address'],
        userName:
            json['userName'] ?? '', // Use empty string if userName is null
        email: json['email'] ?? '', // Use empty string if email is null
        password: json['password'] ?? '', // U
        cart: cart);
  }
  Map<String, dynamic> toJson() => {
        "_id": userId,
        "image": image,
        "address": address,
        "type": type,
        "userName": userName,
        "email": email,
        "password": password,
        "cart": cart != null
            ? List<dynamic>.from(cart!.map((x) => x.toJson()))
            : null,
      };
}
