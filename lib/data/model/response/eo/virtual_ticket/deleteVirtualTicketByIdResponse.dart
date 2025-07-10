import 'dart:convert';

class DeleteVirtualTicketByIdResponseModel {
  final String? status;
  final String? message;

  DeleteVirtualTicketByIdResponseModel({this.status, this.message});

  factory DeleteVirtualTicketByIdResponseModel.fromJson(String str) =>
      DeleteVirtualTicketByIdResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeleteVirtualTicketByIdResponseModel.fromMap(
    Map<String, dynamic> json,
  ) => DeleteVirtualTicketByIdResponseModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {"status": status, "message": message};
}
