part of 'review_bloc.dart';

sealed class ReviewState {}

final class ReviewInitial extends ReviewState {}

final class ReviewLoading extends ReviewState {}

final class ReviewLoadSuccess extends ReviewState {
  final List<Datum> review;
  ReviewLoadSuccess(this.review);
}

final class AddReviewSuccess extends ReviewState {
  final Datum newReview;
  AddReviewSuccess(this.newReview);
}

final class UpdateReviewSuccess extends ReviewState {
  final String editReview;
  UpdateReviewSuccess(this.editReview);
}

final class DeleteReviewSuccess extends ReviewState {
  final String deletedId;
  DeleteReviewSuccess(this.deletedId);
}

final class ReviewFailure extends ReviewState {
  final String error;
  ReviewFailure(this.error);
}
