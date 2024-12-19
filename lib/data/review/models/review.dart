class ReviewModel {
  final String? comment;
  final DateTime? date;
  final int? rating;
  final String? userId;
  final String? userName;
  final String? userAvatar;

  ReviewModel({
    required this.comment,
    required this.date,
    required this.rating,
    required this.userId,
    this.userName,
    this.userAvatar,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      comment: json["comment"],
      date: DateTime.tryParse(json["date"] ?? ""),
      rating: json["rating"],
      userId: json["user_id"],
      userName: json["user_name"], // Added userName
      userAvatar: json["user_avatar"], // Added userAvatar
    );
  }
}
