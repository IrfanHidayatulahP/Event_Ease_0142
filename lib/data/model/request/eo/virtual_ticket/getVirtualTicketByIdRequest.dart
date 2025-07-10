import 'dart:convert';

class GetVirtualTicketByIdRequest {
  final String? orderId;

  GetVirtualTicketByIdRequest({this.orderId});

  factory GetVirtualTicketByIdRequest.fromJson(Map<String, dynamic> json) {
    return GetVirtualTicketByIdRequest(orderId: json['order_id']);
  }

  String toJson() => jsonEncode(toMap());

  factory GetVirtualTicketByIdRequest.fromMap(Map<String, dynamic> json) {
    return GetVirtualTicketByIdRequest(orderId: json['order_id']);
  }

  Map<String, dynamic> toMap() {
    return {'order_id': orderId};
  }
}
