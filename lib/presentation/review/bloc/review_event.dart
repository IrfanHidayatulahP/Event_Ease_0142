part of 'review_bloc.dart';

sealed class ReviewEvent {}

class FetchReviewRequested extends ReviewEvent {
  final String reviewId;
  FetchReviewRequested(this.reviewId);
}

class AddReviewRequest extends ReviewEvent {
  final AddReviewByEventRequestModel newReview;
  AddReviewRequest(this.newReview);
}

class UpdateReviewRequest extends ReviewEvent {
  final int reviewId;
  final int userId;
  final int eventId;
  final double rating;
  final String komen;

  UpdateReviewRequest(
    this.userId,
    this.eventId,
    this.rating,
    this.komen, {
    required this.reviewId,
  });
}

class DeleteReviewRequest extends ReviewEvent {
  final int reviewId;
  final int eventId;
  DeleteReviewRequest({required this.reviewId, required this.eventId});
}
