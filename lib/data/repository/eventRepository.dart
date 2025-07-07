import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_ease/data/model/request/eo/addEventRequest.dart';
import 'package:event_ease/data/model/response/eo/addEventResponse.dart';
import 'package:event_ease/data/model/response/eo/getEventResponse.dart';
import 'package:event_ease/services/service_http_client.dart';

class EventRepository {
  final ServiceHttpClient _client;
  EventRepository(this._client);

  /// Fetch all events (GET /events)
  Future<Either<String, EventResponseModel>> fetchEvents() async {
    try {
      final resp = await _client.get('events');
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
      final resp = await _client.postWithToken('events', req.toMap());
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
}
