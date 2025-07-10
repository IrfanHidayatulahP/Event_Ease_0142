import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_ease/data/model/response/eo/virtual_ticket/addVirtualTicketResponse.dart';
import 'package:event_ease/data/model/response/eo/virtual_ticket/deleteVirtualTicketByIdResponse.dart';
import 'package:event_ease/data/model/response/eo/virtual_ticket/editVirtualTicketByIdResponse.dart';
import 'package:event_ease/data/model/response/eo/virtual_ticket/getAllVirtualTicketResponse.dart';
import 'package:event_ease/data/model/response/eo/virtual_ticket/getVirtualTicketByIdResponse.dart';
import 'package:event_ease/services/service_http_client.dart';

class VirtualTicketRepository {
  final ServiceHttpClient _client;

  VirtualTicketRepository(this._client);

  /// Fetch virtual ticket by ID (GET /virtual-tickets/{id})
  Future<Either<String, GetVirtualTicketsByIdResponseModel>> fetchVirtualTicketById(
    String id,
  ) async {
    try {
      final resp = await _client.get('virtual-tickets/$id');
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(GetVirtualTicketsByIdResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Failed to fetch virtual ticket by ID');
      }
    } catch (e) {
      return Left('Error fetching virtual ticket by ID: $e');
    }
  }

  /// Add a new virtual ticket (POST /virtual-tickets with token)
  Future<Either<String, AddVirtualTicketResponseModel>> addVirtualTicket(
    AddVirtualTicketResponseModel request,
  ) async {
    try {
      final resp = await _client.postWithToken('virtual-tickets', request.toMap());
      final body = json.decode(resp.body);

      if (resp.statusCode == 201 && body['status'] == 'success') {
        return Right(AddVirtualTicketResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Failed to add virtual ticket');
      }
    } catch (e) {
      return Left('Error adding virtual ticket: $e');
    }
  }

  /// Delete virtual ticket by ID (DELETE /virtual-tickets/{id} with token)
  Future<Either<String, DeleteVirtualTicketByIdResponseModel>> deleteVirtualTicket(
    String id,
  ) async {
    try {
      final resp = await _client.deleteWithToken('virtual-tickets/$id');
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(DeleteVirtualTicketByIdResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Failed to delete virtual ticket');
      }
    } catch (e) {
      return Left('Error deleting virtual ticket: $e');
    }
  }

  /// Update virtual ticket by ID (PUT /virtual-tickets/{id} with token)
  Future<Either<String, EditVirtualTicketByIdResponseModel>> updateVirtualTicket(
    String id,
    EditVirtualTicketByIdResponseModel request,
  ) async {
    try {
      final resp = await _client.putWithToken('virtual-tickets/$id', request.toMap());
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(EditVirtualTicketByIdResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Failed to update virtual ticket');
      }
    } catch (e) {
      return Left('Error updating virtual ticket: $e');
    }
  }

  /// Fetch all virtual tickets (GET /virtual-tickets)
  Future<Either<String, List<GetAllVirtualTicketsResponseModel>>> fetchAllVirtualTickets() async {
    try {
      final resp = await _client.get('virtual-tickets');
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        List<GetVirtualTicketsByIdResponseModel> tickets = (body['data'] as List)
            .map((ticket) => GetVirtualTicketsByIdResponseModel.fromMap(ticket))
            .toList();
        return Right(tickets.cast<GetAllVirtualTicketsResponseModel>());
      } else {
        return Left(body['message'] ?? 'Failed to fetch virtual tickets');
      }
    } catch (e) {
      return Left('Error fetching virtual tickets: $e');
    }
  }
}