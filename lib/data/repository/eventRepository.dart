import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_ease/data/model/request/eo/event/addEventRequest.dart';
import 'package:event_ease/data/model/request/eo/event/editEventRequest.dart';
import 'package:event_ease/data/model/response/eo/event/addEventResponse.dart';
import 'package:event_ease/data/model/response/eo/event/getEventResponse.dart';
import 'package:event_ease/services/service_http_client.dart';

class EventRepository {
  final ServiceHttpClient _client;
  EventRepository(this._client);

  /// Fetch all events (GET /events)
  Future<Either<String, EventResponseModel>> fetchEvents() async {
    try {
      final resp = await _client.get('event');
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(EventResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Gagal memuat event');
      }
    } catch (e) {
      return Left('Error fetching events: $e');
    }
  }

  /// Tambah event (POST /events with token)
  Future<Either<String, AddEventResponse>> addEvent(AddEventRequest req) async {
    try {
      final resp = await _client.postWithToken('event', req.toMap());
      final body = json.decode(resp.body);

      if (resp.statusCode == 201 && body['status'] == 'success') {
        return Right(AddEventResponse.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Gagal menambah event');
      }
    } catch (e) {
      return Left('Error adding event: $e');
    }
  }

  /// Fetch event by ID (GET /events/{id})
  Future<Either<String, EventResponseModel>> fetchEventById(String id) async {
    try {
      final resp = await _client.get('event/$id');
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(EventResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Gagal memuat event');
      }
    } catch (e) {
      return Left('Error fetching event by ID: $e');
    }
  }

  /// Update event (PUT /events/{id} with token)
  Future<Either<String, EventResponseModel>> updateEvent(String id, EditEventRequestModel req) async {
    try {
      final resp = await _client.putWithToken('event/$id', req.toMap());
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(EventResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Gagal memperbarui event');
      }
    } catch (e) {
      return Left('Error updating event: $e');
    }
  }

  /// Delete event (DELETE /events/{id} with token)
  Future<Either<String, String>> deleteEvent(String id) async {
    try {
      final resp = await _client.deleteWithToken('event/$id');
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right('Event deleted successfully');
      } else {
        return Left(body['message'] ?? 'Gagal menghapus event');
      }
    } catch (e) {
      return Left('Error deleting event: $e');
    }
  }
}
