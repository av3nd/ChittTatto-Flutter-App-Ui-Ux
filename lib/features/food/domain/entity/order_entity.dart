class OrderEntity {
  final String? orderId;
  final List<Map<String, dynamic>>
      foods; // Change the type to List<Map<String, dynamic>>
  final String address;
  final String userId;
  final int orderedAt;
  final int status;
  final int price;

  final int totalPrice; // Change the type to int
  OrderEntity({
    this.orderId,
    required this.foods,
    required this.address,
    required this.userId,
    required this.orderedAt,
    required this.status,
    required this.price,
    required this.totalPrice,
  });

  factory OrderEntity.fromJson(Map<String, dynamic> json) => OrderEntity(
        orderId: json["_id"],
        foods: (json["foods"] as List<dynamic>)
            .cast<Map<String, dynamic>>(), // Cast the list to the correct type
        address: json["address"],
        userId: json["userId"],
        orderedAt: json["orderedAt"] as int? ?? 0,
        status: json["status"] as int? ?? 0,
        price: json["price"] as int? ?? 0,
        totalPrice: json["totalPrice"] as int, // Parse totalPrice as int
      );

  Map<String, dynamic> toJson() => {
        "_id": orderId,
        "foods": foods,
        "userId": userId,
        "orderedAt": orderedAt,
        "status": status,
        "price": price,
        "totalPrice": totalPrice,
      };
}
