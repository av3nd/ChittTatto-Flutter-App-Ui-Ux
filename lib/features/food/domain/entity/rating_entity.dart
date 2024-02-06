class RatingEntity {
  final String userId;
  final double rating;

  RatingEntity({required this.userId, required this.rating});

  factory RatingEntity.fromJson(Map<String, dynamic> json) {
    return RatingEntity(
      userId: json['userId'] as String,
      rating: json['rating'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'rating': rating,
    };
  }
}
