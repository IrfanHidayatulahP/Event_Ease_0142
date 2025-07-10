import 'dart:io';

import 'package:event_ease/data/model/response/eo/orders/getAllOrdersResponse.dart';
import 'package:http/http.dart' as http;

class GetAllOrdersRequestModel {
  final String baseUrl;
  final String token;

  GetAllOrdersRequestModel({required this.baseUrl, required this.token});

  Future<GetAllOrderResponseModel> ambilSemuaOrders() async {
    final uri = Uri.parse('$baseUrl/api/orders');

    final response = await http.get(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // parsing JSON menjadi model GetAllOrderResponseModel
      return GetAllOrderResponseModel.fromJson(response.body);
    } else {
      // lempar error jika gagal
      throw HttpException(
        'Gagal mengambil data orders: '
        '${response.statusCode} ${response.reasonPhrase}',
      );
    }
  }
}
