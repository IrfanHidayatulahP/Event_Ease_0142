import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_ease/data/model/response/eo/tickets/addTicketByEventResponse.dart';
import 'package:event_ease/data/model/response/eo/tickets/deleteTicketByIdResponse.dart';
import 'package:event_ease/data/model/response/eo/tickets/editTicketByIdResponse.dart';
import 'package:event_ease/data/model/response/eo/tickets/getTicketByEventResponse.dart';
import 'package:event_ease/data/model/response/eo/tickets/getTicketByIdResponse.dart';
import 'package:event_ease/services/service_http_client.dart';

class TicketRepository {
  final ServiceHttpClient _client;

  TicketRepository(this._client);

  /// Fetch all tickets (GET /tickets)
  Future<Either<String, GetTicketByEventResponseModel>> fetchTickets(String eventId) async {
    try {
      final resp = await _client.get('event/$eventId/tickets');
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(GetTicketByEventResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Failed to fetch tickets');
      }
    } catch (e) {
      return Left('Error fetching tickets: $e');
    }
  }

  /// Add a new ticket (POST /tickets with token)
  Future<Either<String, AddTicketByEventResponseModel>> addTicket(
    AddTicketByEventResponseModel request,
  ) async {
    try {
      final resp = await _client.postWithToken('tickets', request.toMap());
      final body = json.decode(resp.body);

      if (resp.statusCode == 201 && body['status'] == 'success') {
        return Right(AddTicketByEventResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Failed to add ticket');
      }
    } catch (e) {
      return Left('Error adding ticket: $e');
    }
  }

  /// Fetch ticket by ID (GET /tickets/{id})
  Future<Either<String, GetTicketByIdResponseModel>> fetchTicketById(
    String id,
  ) async {
    try {
      final resp = await _client.get('tickets/$id');
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(GetTicketByIdResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Failed to fetch ticket by ID');
      }
    } catch (e) {
      return Left('Error fetching ticket by ID: $e');
    }
  }

  /// Delete ticket by ID (DELETE /tickets/{id} with token)
  Future<Either<String, DeleteTicketByIdResponseModel>> deleteTicket(
    String id,
  ) async {
    try {
      final resp = await _client.deleteWithToken('tickets/$id');
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(DeleteTicketByIdResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Failed to delete ticket');
      }
    } catch (e) {
      return Left('Error deleting ticket: $e');
    }
  }

  /// Update ticket by ID (PUT /tickets/{id} with token)
  Future<Either<String, EditTicketByIdResponseModel>> updateTicket(
    String id,
    EditTicketByIdResponseModel request,
  ) async {
    try {
      final resp = await _client.putWithToken('tickets/$id', request.toMap());
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(EditTicketByIdResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Failed to update ticket');
      }
    } catch (e) {
      return Left('Error updating ticket: $e');
    }
  }
}
