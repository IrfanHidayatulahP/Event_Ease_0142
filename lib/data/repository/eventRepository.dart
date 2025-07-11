import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_ease/data/model/request/eo/event/addEventRequest.dart';
import 'package:event_ease/data/model/request/eo/event/editEventRequest.dart';
import 'package:event_ease/data/model/response/eo/event/addEventResponse.dart';
import 'package:event_ease/data/model/response/eo/event/editEventResponse.dart';
import 'package:event_ease/data/model/response/eo/event/getEventResponse.dart';
import 'package:event_ease/services/service_http_client.dart';

class EventRepository {
  final ServiceHttpClient _client;
  EventRepository(this._client);

  /// Fetch all events (GET /event)
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

  /// Tambah event (POST /event/add)
  Future<Either<String, AddEventResponse>> addEvent(AddEventRequest req) async {
    try {
      final resp = await _client.postWithToken('event/add', req.toMap());
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

  /// Update event (PUT /event/edit/{id})
  Future<Either<String, EditEventResponseModel>> updateEvent(
    String id,
    EditEventRequestModel req,
  ) async {
    try {
      final resp = await _client.putWithToken('event/edit/$id', req.toMap());
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(EditEventResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Gagal memperbarui event');
      }
    } catch (e) {
      return Left('Error updating event: $e');
    }
  }

  /// Delete event (DELETE /event/{id})
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
