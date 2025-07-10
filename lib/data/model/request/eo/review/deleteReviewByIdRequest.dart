import 'dart:convert';

class DeleteEventResponseModel {
  final String? status;

  DeleteEventResponseModel({this.status});

  factory DeleteEventResponseModel.fromJson(String str) =>
      DeleteEventResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeleteEventResponseModel.fromMap(Map<String, dynamic> json) =>
      DeleteEventResponseModel(status: json["status"]);

  Map<String, dynamic> toMap() => {"status": status};
}
