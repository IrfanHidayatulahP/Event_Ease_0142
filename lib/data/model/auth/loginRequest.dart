import 'dart:convert';

class LoginRequestModel {
  final String? email;
  final String? password;
  final String? photoPath;

  LoginRequestModel({this.email, this.password, this.photoPath});

  factory LoginRequestModel.fromJson(String str) =>
      LoginRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginRequestModel.fromMap(Map<String, dynamic> json) =>
      LoginRequestModel(email: json["email"], password: json["password"], photoPath: json["photo_path"]);

  Map<String, dynamic> toMap() => {"email": email, "password": password, "photo_path": photoPath};
}
