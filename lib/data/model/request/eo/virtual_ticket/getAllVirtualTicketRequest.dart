import 'package:event_ease/data/model/response/eo/virtual_ticket/getAllVirtualTicketResponse.dart';
import 'package:http/http.dart' as http;

class GetAllVirtualTicketRequest {
  final String baseUrl;
  final String token;

  GetAllVirtualTicketRequest({required this.baseUrl, required this.token});

  Future<GetAllVirtualTicketsResponseModel> sendRequest() async {
    final response = await http.get(
      Uri.parse('$baseUrl/virtual-tickets'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return GetAllVirtualTicketsResponseModel.fromJson(response.body);
    } else {
      throw Exception('Failed to load virtual tickets');
    }
  }
}
