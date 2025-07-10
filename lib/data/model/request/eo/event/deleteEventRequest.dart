import 'dart:io';
import 'package:event_ease/data/model/response/eo/event/deleteEventResponse.dart';
import 'package:http/http.dart' as http;

class DeleteEvent {
  final String baseUrl;
  final String token;

  DeleteEvent({required this.baseUrl, required this.token});
  /// Menghapus event berdasarkan ID
  Future<DeleteEventResponseModel> deleteEvent(String eventId) async {
    final uri = Uri.parse('$baseUrl/api/events/$eventId');

    final response = await http.delete(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // parsing JSON menjadi model DeleteEventResponseModel
      return DeleteEventResponseModel.fromJson(response.body);
    } else {
      // lempar error jika gagal
      throw HttpException(
        'Gagal menghapus event: '
        '${response.statusCode} ${response.reasonPhrase}',
      );
    }
  }
}