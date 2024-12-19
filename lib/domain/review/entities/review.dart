class ReviewEntity {
  final String? comment;
  final DateTime? date;
  final int? rating;
  final String? userId;
  final String? userName;
  final String? userAvatar;

  ReviewEntity({
    required this.comment,
    required this.date,
    required this.rating,
    required this.userId,
    this.userName,
    this.userAvatar,
  });
}
