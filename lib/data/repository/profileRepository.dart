import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_ease/data/model/request/eo/profile/editProfileRequest.dart';
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
    EditProfileRequestModel model,
  ) async {
    print('>>> updateProfile: start');
    try {
      final resp = await _client.putWithToken('profile/edit', model.toMap());
      print('>>> HTTP status: ${resp.statusCode}');
      if (resp.statusCode == 200) {
        final jsonBody = json.decode(resp.body) as Map<String, dynamic>;
        final data = EditProfileResponseModel.fromMap(jsonBody);
        print('>>> parsed response OK');
        return Right(data);
      } else {
        print('>>> error status: ${resp.statusCode}');
        return Left('Server error: ${resp.statusCode}');
      }
    } catch (e, st) {
      print('>>> exception: $e\n$st');
      return Left('Exception: $e');
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
