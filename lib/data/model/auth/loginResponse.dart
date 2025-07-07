// loginResponseModel.dart
import 'dart:convert';

class LoginResponseModel {
  final String? status;
  final String? token;
  final Data? user;

  LoginResponseModel({this.status, this.token, this.user});

  factory LoginResponseModel.fromJson(String str) =>
      LoginResponseModel.fromMap(json.decode(str));

  factory LoginResponseModel.fromMap(Map<String, dynamic> json) =>
      LoginResponseModel(
        status: json["status"] as String?,
        token: json["token"] as String?,
        user:
            json["user"] == null
                ? null
                : Data.fromMap(json["user"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
    "status": status,
    "token": token,
    "user": user?.toMap(),
  };
}

class Data {
  final int? id;
  final String? username;
  final String? email;
  final String? role;

  Data({this.id, this.username, this.email, this.role});

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"] as int?,
    username: json["username"] as String?,
    email: json["email"] as String?,
    role: json["role"] as String?,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "username": username,
    "email": email,
    "role": role,
  };
}
