import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_ease/data/model/request/eo/orders/addOrderRequest.dart';
import 'package:event_ease/data/model/response/eo/orders/addOrderResponse.dart';
import 'package:event_ease/data/model/response/eo/orders/deleteOrderResponse.dart';
import 'package:event_ease/data/model/response/eo/orders/editOrderResponse.dart';
import 'package:event_ease/data/model/response/eo/orders/getAllOrdersResponse.dart';
import 'package:event_ease/data/model/response/eo/orders/getOrderByIdResponse.dart';
import 'package:event_ease/services/service_http_client.dart';

class OrderRepository {
  final ServiceHttpClient _client;

  OrderRepository(this._client);

  /// Fetch all orders (GET /orders)
  Future<Either<String, GetAllOrderResponseModel>> fetchOrders() async {
    try {
      final resp = await _client.get('orders');
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(GetAllOrderResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Failed to fetch orders');
      }
    } catch (e) {
      return Left('Error fetching orders: $e');
    }
  }

  /// Add a new order (POST /orders with token)
  Future<Either<String, AddOrderResponseModel>> addOrder(
    AddOrderRequestModel request,
  ) async {
    try {
      final resp = await _client.postWithToken('orders', request.toMap());
      final body = json.decode(resp.body);
      if (resp.statusCode == 201 && body['status'] == 'success') {
        return Right(AddOrderResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Failed to add order');
      }
    } catch (e) {
      return Left('Error adding order: $e');
    }
  }

  /// Fetch order by ID (GET /orders/{id})
  Future<Either<String, GetOrderByIdResponseModel>> fetchOrderById(
    String id,
  ) async {
    try {
      final resp = await _client.get('orders/$id');
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(GetOrderByIdResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Failed to fetch order by ID');
      }
    } catch (e) {
      return Left('Error fetching order by ID: $e');
    }
  }

  /// Delete order by ID (DELETE /orders/{id} with token)
  Future<Either<String, DeleteOrderResponseModel>> deleteOrder(
    String id,
  ) async {
    try {
      final resp = await _client.deleteWithToken('orders/$id');
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(DeleteOrderResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Failed to delete order');
      }
    } catch (e) {
      return Left('Error deleting order: $e');
    }
  }

  /// Update order by ID (PUT /orders/{id} with token)
  Future<Either<String, EditOrderResponseModel>> updateOrder(
    String id,
    AddOrderRequestModel request,
  ) async {
    try {
      final resp = await _client.putWithToken('orders/$id', request.toMap());
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(EditOrderResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Failed to update order');
      }
    } catch (e) {
      return Left('Error updating order: $e');
    }
  }
}
