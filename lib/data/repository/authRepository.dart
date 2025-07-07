import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_ease/data/model/auth/loginRequest.dart';
import 'package:event_ease/data/model/auth/loginResponse.dart';
import 'package:event_ease/data/model/auth/registerRequest.dart';
import 'package:event_ease/services/service_http_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final ServiceHttpClient _http;
  final _secureStorage = const FlutterSecureStorage();

  AuthRepository(this._http);

  /// Login: simpan token ke secure storage
  Future<Either<String, LoginResponseModel>> login(
    LoginRequestModel req,
  ) async {
    try {
      final resp = await _http.post('auth/login', req.toMap());
      final body = json.decode(resp.body);

      if (resp.statusCode == 200 && body['status'] == 'success') {
        final loginRes = LoginResponseModel.fromMap(body);

        // Simpan JWT ke secure storage
        if (loginRes.token != null) {
          await _secureStorage.write(key: 'AuthToken', value: loginRes.token);
        } else {
          return Left('Response tidak mengandung token');
        }

        return Right(loginRes);
      } else {
        return Left(body['message'] ?? 'Login gagal');
      }
    } catch (e) {
      return Left('Error saat login: $e');
    }
  }

  /// Register (tidak perlu simpan token)
  Future<Either<String, String>> register(RegisterRequestModel req) async {
    try {
      final resp = await _http.post('auth/register', req.toMap());
      final body = json.decode(resp.body);

      if (resp.statusCode == 201 && body['status'] == 'success') {
        return Right('Registrasi berhasil');
      } else {
        return Left(body['message'] ?? 'Registrasi gagal');
      }
    } catch (e) {
      return Left('Error saat registrasi: $e');
    }
  }
}
