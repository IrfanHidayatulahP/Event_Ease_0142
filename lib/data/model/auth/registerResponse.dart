import 'dart:convert';

class RegisterResponseModel {
  final String? status;
  final Data? data;

  RegisterResponseModel({this.status, this.data});

  factory RegisterResponseModel.fromJson(String str) =>
      RegisterResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterResponseModel.fromMap(Map<String, dynamic> json) =>
      RegisterResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {"status": status, "data": data?.toMap()};
}

class Data {
  final int? id;
  final String? username;
  final String? email;
  final String? role;

  Data({this.id, this.username, this.email, this.role});

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    role: json["role"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "username": username,
    "email": email,
    "role": role,
  };
}
