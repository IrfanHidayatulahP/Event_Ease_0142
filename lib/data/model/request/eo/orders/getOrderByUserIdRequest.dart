import 'dart:convert';

class GetOrderByUserIdRequest {
  final int? userId;

  GetOrderByUserIdRequest({required this.userId});

  factory GetOrderByUserIdRequest.fromJson(String str) =>
      GetOrderByUserIdRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetOrderByUserIdRequest.fromMap(Map<String, dynamic> json) =>
      GetOrderByUserIdRequest(userId: json["user_id"]);

  Map<String, dynamic> toMap() => {"user_id": userId};
}
