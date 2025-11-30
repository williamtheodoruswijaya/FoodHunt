class ReviewModel {
  final int reviewId;
  final int userId;
  final int rating;
  final String? comment;

  ReviewModel({
    required this.reviewId,
    required this.userId,
    required this.rating,
    this.comment,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      reviewId: json["reviewId"],
      userId: json["userId"],
      rating: json["rating"],
      comment: json["comment"],
    );
  }
}
