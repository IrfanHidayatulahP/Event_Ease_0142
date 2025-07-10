import 'dart:convert';

class DeleteTicketByIdResponseModel {
  final String? status;
  final String? message;

  DeleteTicketByIdResponseModel({this.status, this.message});

  factory DeleteTicketByIdResponseModel.fromJson(String str) =>
      DeleteTicketByIdResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeleteTicketByIdResponseModel.fromMap(Map<String, dynamic> json) =>
      DeleteTicketByIdResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {"status": status, "message": message};
}
