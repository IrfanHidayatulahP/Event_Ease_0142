import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ServiceHttpClient {
  final String baseUrl = 'http://10.0.2.2:3000/api/';
  final _secureStorage = const FlutterSecureStorage();
  final _inner = http.Client();

  /// POST tanpa token (register / login)
  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return _inner.post(
      url,
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(body),
    );
  }

  /// POST dengan token (butuh autentikasi)
  Future<http.Response> postWithToken(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _buildAuthHeaders();
    return _inner.post(url, headers: headers, body: jsonEncode(body));
  }

  /// GET dengan token (butuh autentikasi)
  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _buildAuthHeaders();
    return _inner.get(url, headers: headers);
  }

  /// PUT dengan token (butuh autentikasi)
  Future<http.Response> putWithToken(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _buildAuthHeaders();
    return _inner.put(url, headers: headers, body: jsonEncode(body));
  }

  /// DELETE dengan token (butuh autentikasi)
  Future<http.Response> deleteWithToken(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _buildAuthHeaders();
    return _inner.delete(url, headers: headers);
  }

  /// Bangun header JSON + Bearer token jika ada
  Future<Map<String, String>> _buildAuthHeaders() async {
    final token = await _secureStorage.read(key: 'AuthToken');
    final headers = <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    if (token != null) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }
    return headers;
  }
}
