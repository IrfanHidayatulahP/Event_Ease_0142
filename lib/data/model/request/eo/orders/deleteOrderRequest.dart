import 'dart:convert';

class DeleteRrderRequest {
  final int? orderId;

  DeleteRrderRequest({this.orderId});

  factory DeleteRrderRequest.fromJson(String str) =>
      DeleteRrderRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeleteRrderRequest.fromMap(Map<String, dynamic> json) =>
      DeleteRrderRequest(orderId: json["order_id"]);

  Map<String, dynamic> toMap() => {"order_id": orderId};
}
