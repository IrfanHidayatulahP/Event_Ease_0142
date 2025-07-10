import 'dart:convert';

class GetOrderByIdRequest {
  final int? orderId;

  GetOrderByIdRequest({this.orderId});

  factory GetOrderByIdRequest.fromJson(String str) =>
      GetOrderByIdRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetOrderByIdRequest.fromMap(Map<String, dynamic> json) =>
      GetOrderByIdRequest(orderId: json["order_id"]);

  Map<String, dynamic> toMap() => {"order_id": orderId};
}
