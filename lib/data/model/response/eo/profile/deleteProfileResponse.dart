import 'dart:convert';

class EditProfileResponseModel {
  final String? status;
  final String? message;

  EditProfileResponseModel({this.status, this.message});

  factory EditProfileResponseModel.fromJson(String str) =>
      EditProfileResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EditProfileResponseModel.fromMap(Map<String, dynamic> json) =>
      EditProfileResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {"status": status, "message": message};
}
