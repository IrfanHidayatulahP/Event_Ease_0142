import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_ease/data/model/response/eo/profile/deleteProfileResponse.dart';
import 'package:event_ease/data/model/response/eo/profile/editProfileResponse.dart';
import 'package:event_ease/data/model/response/eo/profile/getProfileResponse.dart';
import 'package:event_ease/services/service_http_client.dart';

class ProfileRepository {
  final ServiceHttpClient _client;

  ProfileRepository(this._client);

  /// Fetch user profile (GET /profile)
  Future<Either<String, GetProfileResponseModel>> fetchProfile() async {
    try {
      final resp = await _client.get('profile');
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(GetProfileResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Failed to fetch profile');
      }
    } catch (e) {
      return Left('Error fetching profile: $e');
    }
  }

  /// Update user profile (PUT /profile with token)
  Future<Either<String, EditProfileResponseModel>> updateProfile(
    EditProfileResponseModel request,
  ) async {
    try {
      final resp = await _client.putWithToken('profile', request.toMap());
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(EditProfileResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Failed to update profile');
      }
    } catch (e) {
      return Left('Error updating profile: $e');
    }
  }

  /// Delete user profile (DELETE /profile with token)
  Future<Either<String, DeleteProfileResponseModel>> deleteProfile() async {
    try {
      final resp = await _client.deleteWithToken('profile');
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        return Right(DeleteProfileResponseModel.fromMap(body));
      } else {
        return Left(body['message'] ?? 'Failed to delete profile');
      }
    } catch (e) {
      return Left('Error deleting profile: $e');
    }
  }
}
