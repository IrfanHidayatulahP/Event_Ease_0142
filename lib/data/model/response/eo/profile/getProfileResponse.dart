import 'dart:convert';

class GetProfileResponseModel {
  final String? status;
  final Data? data;

  GetProfileResponseModel({this.status, this.data});

  factory GetProfileResponseModel.fromJson(String str) =>
      GetProfileResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetProfileResponseModel.fromMap(Map<String, dynamic> json) =>
      GetProfileResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {"status": status, "data": data?.toMap()};
}

class Data {
  final int? id;
  final String? username;
  final String? email;
  final dynamic photoPath;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Data({
    this.id,
    this.username,
    this.email,
    this.photoPath,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    photoPath: json["photo_path"],
    role: json["role"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "username": username,
    "email": email,
    "photo_path": photoPath,
    "role": role,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
