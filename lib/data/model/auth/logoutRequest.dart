import 'dart:convert';

class LogoutRequestModel {
  final String? email;
  final String? password;

  LogoutRequestModel({this.email, this.password});

  factory LogoutRequestModel.fromJson(String str) =>
      LogoutRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LogoutRequestModel.fromMap(Map<String, dynamic> json) =>
      LogoutRequestModel(email: json["email"], password: json["password"]);

  Map<String, dynamic> toMap() => {"email": email, "password": password};
}
