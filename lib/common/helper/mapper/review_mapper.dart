import 'package:glassify_flutter/data/review/models/review.dart';
import 'package:glassify_flutter/domain/review/entities/review.dart';

class ReviewMapper {
  static ReviewEntity toEntity(ReviewModel review) {
    return ReviewEntity(
        userId: review.userId,
        comment: review.comment,
        date: review.date,
        rating: review.rating,
        userAvatar: review.userAvatar,
        userName: review.userName);
  }
}
