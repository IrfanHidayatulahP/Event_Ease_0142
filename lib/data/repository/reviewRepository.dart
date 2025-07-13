import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_ease/data/model/response/eo/review/addReviewByEventResponse.dart';
import 'package:event_ease/data/model/response/eo/review/deleteReviewByIdResponse.dart';
import 'package:event_ease/data/model/response/eo/review/editReviewByIdResponse.dart';
import 'package:event_ease/data/model/response/eo/review/getReviewByEventResponse.dart';
import 'package:event_ease/data/model/response/eo/review/getReviewByIdResponse.dart';
import 'package:event_ease/services/service_http_client.dart';

class ReviewRepository {
  final ServiceHttpClient _client;

  ReviewRepository(this._client);

  /// Add a new review (POST /reviews with token)
  Future<Either<String, AddReviewByEventResponseModel>> addReview(
    AddReviewByEventResponseModel request,
  ) async {
    try {
      final resp = await _client.postWithToken('reviews', request.toMap());
      final body = json.decode(resp.body);

      if (resp.statusCode == 201 && body['status'] == 'success') {
        return Right(AddReviewByEventResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Failed to add review');
      }
    } catch (e) {
      return Left('Error adding review: $e');
    }
  }

  /// Fetch review by ID (GET /reviews/{id})
  Future<Either<String, GetReviewByIdResponseModel>> fetchReviewById(
    String id,
  ) async {
    try {
      final resp = await _client.get('reviews/$id');
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(GetReviewByIdResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Failed to fetch review by ID');
      }
    } catch (e) {
      return Left('Error fetching review by ID: $e');
    }
  }

  /// Delete review by ID (DELETE /reviews/{id} with token)
  Future<Either<String, DeleteReviewByIdResponseModel>> deleteReview(
    String id,
  ) async {
    try {
      final resp = await _client.deleteWithToken('reviews/$id');
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(DeleteReviewByIdResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Failed to delete review');
      }
    } catch (e) {
      return Left('Error deleting review: $e');
    }
  }

  /// Update review by ID (PUT /reviews/{id} with token)
  Future<Either<String, EditReviewByIdResponseModel>> updateReview(
    String id,
    EditReviewByIdResponseModel request,
  ) async {
    try {
      final resp = await _client.putWithToken('reviews/$id', request.toMap());
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(EditReviewByIdResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Failed to update review');
      }
    } catch (e) {
      return Left('Error updating review: $e');
    }
  }

  /// Fetch reviews by event ID (GET /events/{id}/reviews)
  Future<Either<String, GetReviewByEventResponseModel>> fetchReviewsByEventId(
    String eventId,
  ) async {
    try {
      final resp = await _client.get('event/reviews/$eventId');
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(GetReviewByEventResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Failed to fetch reviews by event ID');
      }
    } catch (e) {
      return Left('Error fetching reviews by event ID: $e');
    }
  }
}
