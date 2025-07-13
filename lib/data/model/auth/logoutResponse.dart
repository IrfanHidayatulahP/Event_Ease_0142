import 'dart:convert';

class LogoutResponseModel {
  final String? status;
  final String? message;

  LogoutResponseModel({this.status, this.message});

  factory LogoutResponseModel.fromJson(String str) =>
      LogoutResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LogoutResponseModel.fromMap(Map<String, dynamic> json) =>
      LogoutResponseModel(status: json["status"], message: json["message"]);

  Map<String, dynamic> toMap() => {"status": status, "message": message};
}
