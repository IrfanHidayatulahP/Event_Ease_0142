import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_ease/data/model/request/eo/event/addEventRequest.dart';
import 'package:event_ease/data/model/request/eo/images/editImageRequest.dart';
import 'package:event_ease/data/model/response/eo/images/addImageResponse.dart';
import 'package:event_ease/data/model/response/eo/images/editImageResponse.dart';
import 'package:event_ease/data/model/response/eo/images/getImageByEventResponse.dart';
import 'package:event_ease/services/service_http_client.dart';

class ImageRepository {
  final ServiceHttpClient _client;
  ImageRepository(this._client);

  Future<Either<String, GetImageByEventResponseModel>> fetchImage() async {
    try {
      final resp = await _client.get('image');
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(GetImageByEventResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Gagal memuat event');
      }
    } catch (e) {
      return Left('Error fetching events: $e');
    }
  }

  Future<Either<String, AddImageResponseModel>> addImage(AddEventRequest req) async {
    try {
      final resp = await _client.postWithToken('image', req.toMap());
      final body = json.decode(resp.body);

      if (resp.statusCode == 201 && body['status'] == 'success') {
        return Right(AddImageResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Gagal menambah event');
      }
    } catch (e) {
      return Left('Error adding event: $e');
    }
  }

  Future<Either<String, EditImageResponseModel>> updateImage(
    String id,
    EditImageRequestModel req,
  ) async {
    try {
      final resp = await _client.putWithToken('image/$id', req.toMap());
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(EditImageResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Gagal memperbarui event');
      }
    } catch (e) {
      return Left('Error updating event: $e');
    }
  }
}
