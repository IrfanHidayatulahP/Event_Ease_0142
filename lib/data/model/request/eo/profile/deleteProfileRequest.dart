import 'dart:convert';

class DeleteProfileRequestModel {
  final String? id;

  DeleteProfileRequestModel({this.id});

  factory DeleteProfileRequestModel.fromJson(String str) =>
      DeleteProfileRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeleteProfileRequestModel.fromMap(Map<String, dynamic> json) =>
      DeleteProfileRequestModel(id: json["id"]);

  Map<String, dynamic> toMap() => {"id": id};
}
