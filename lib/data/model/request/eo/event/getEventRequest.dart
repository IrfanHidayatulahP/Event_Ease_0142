import 'dart:io';
import 'package:event_ease/data/model/response/eo/event/getEventResponse.dart';
import 'package:http/http.dart' as http;

class EventApi {
  final String baseUrl;
  final String token;

  EventApi({required this.baseUrl, required this.token});

  /// Mengambil semua event untuk EO yang sedang login
  Future<EventResponseModel> ambilEvent() async {
    final uri = Uri.parse('$baseUrl/api/events');

    final response = await http.get(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // parsing JSON menjadi model EventResponseModel
      return EventResponseModel.fromJson(response.body);
    } else {
      // lempar error jika gagal
      throw HttpException(
        'Gagal mengambil data event: '
        '${response.statusCode} ${response.reasonPhrase}',
      );
    }
  }
}
