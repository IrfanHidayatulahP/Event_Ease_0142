import 'dart:convert';

class GetProfileRequestModel {
  final String? username;
  final String? email;
  final dynamic photoPath;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GetProfileRequestModel({
    this.username,
    this.email,
    this.photoPath,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  factory GetProfileRequestModel.fromJson(String str) =>
      GetProfileRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetProfileRequestModel.fromMap(
    Map<String, dynamic> json,
  ) => GetProfileRequestModel(
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
    "username": username,
    "email": email,
    "photo_path": photoPath,
    "role": role,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
