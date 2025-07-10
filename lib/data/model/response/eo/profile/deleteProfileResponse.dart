import 'dart:convert';

class DeleteProfileResponseModel {
  final String? status;
  final String? message;

  DeleteProfileResponseModel({this.status, this.message});

  factory DeleteProfileResponseModel.fromJson(String str) =>
      DeleteProfileResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeleteProfileResponseModel.fromMap(Map<String, dynamic> json) =>
      DeleteProfileResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {"status": status, "message": message};
}
