import 'dart:convert';

class EditProfileRequestModel {
  final String? id;

  EditProfileRequestModel({this.id});

  factory EditProfileRequestModel.fromJson(String str) =>
      EditProfileRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EditProfileRequestModel.fromMap(Map<String, dynamic> json) =>
      EditProfileRequestModel(id: json["id"]);

  Map<String, dynamic> toMap() => {"id": id};
}
