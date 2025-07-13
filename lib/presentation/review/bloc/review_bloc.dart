import 'package:bloc/bloc.dart';
import 'package:event_ease/data/model/request/eo/review/addReviewByEventRequest.dart';
import 'package:event_ease/data/model/request/eo/review/editReviewByIdRequest.dart';
import 'package:event_ease/data/model/response/eo/review/addReviewByEventResponse.dart';
import 'package:event_ease/data/model/response/eo/review/editReviewByIdResponse.dart';
import 'package:event_ease/data/model/response/eo/review/getReviewByEventResponse.dart';
import 'package:event_ease/data/repository/reviewRepository.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepository repo;

  ReviewBloc(this.repo) : super(ReviewInitial()) {
    on<FetchReviewRequested>(_onFetch);
    on<AddReviewRequest>(_onAdd);
    on<UpdateReviewRequest>(_onUpdate);
    on<DeleteReviewRequest>(_onDelete);
  }

  Future<void> _onFetch(
    FetchReviewRequested event,
    Emitter<ReviewState> emit,
  ) async {
    emit(ReviewLoading());
    final result = await repo.fetchReviewsByEventId(event.reviewId);
    result.fold(
      (l) => emit(ReviewFailure(l)),
      (r) => emit(ReviewLoadSuccess(r.data ?? [])),
    );
  }

  Future<void> _onAdd(AddReviewRequest event, Emitter<ReviewState> emit) async {
    emit(ReviewLoading());
    try {
      final result = await repo.addReview(event.newReview as AddReviewByEventResponseModel);
      result.fold((failure) => emit(ReviewFailure(failure)), (response) {
        final d = response.data!;
        final newDatum = Datum(
          id: d.id,
          userId: d.userId,
          eventId: d.eventId,
          rating: d.rating,
          comment: d.comment,
        );
        emit(AddReviewSuccess(newDatum));
      });
    } catch (e) {
      emit(ReviewFailure(e.toString()));
    }
  }

  Future<void> _onUpdate(
    UpdateReviewRequest event,
    Emitter<ReviewState> emit,
  ) async {
    emit(ReviewLoading());

    final req = EditReviewByIdRequestModel(
      id: event.reviewId,
      userId: event.userId,
      eventId: event.eventId,
      rating: event.rating.toString(),
      comment: event.komen,
    );

    final result = await repo.updateReview(event.reviewId.toString(), req as EditReviewByIdResponseModel);

    result.fold((failure) => emit(ReviewFailure(failure)), (response) {
      final d = response.data!;
      final updated = Datum(
        id: d.id,
        userId: d.userId,
        eventId: d.eventId,
        rating: d.rating,
        comment: d.comment,
      );
      emit(UpdateReviewSuccess(updated as String));
    });
  }

  Future<void> _onDelete(
    DeleteReviewRequest event,
    Emitter<ReviewState> emit,
  ) async {
    emit(ReviewLoading());
    final result = await repo.deleteReview(event.reviewId.toString());
    result.fold((failure) => emit(ReviewFailure(failure)), (_) {
      emit(DeleteReviewSuccess(event.reviewId.toString()));
      add(FetchReviewRequested(event.eventId.toString()));
    });
  }
}
