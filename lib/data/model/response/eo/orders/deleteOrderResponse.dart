import 'dart:convert';

class DeleteOrderResponseModel {
  final String? status;
  final String? message;

  DeleteOrderResponseModel({this.status, this.message});

  factory DeleteOrderResponseModel.fromJson(String str) =>
      DeleteOrderResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeleteOrderResponseModel.fromMap(Map<String, dynamic> json) =>
      DeleteOrderResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {"status": status, "message": message};
}
