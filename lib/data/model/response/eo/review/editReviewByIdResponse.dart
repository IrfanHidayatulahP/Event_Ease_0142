import 'dart:convert';

class EditReviewByIdResponseModel {
  final String? status;
  final Data? data;

  EditReviewByIdResponseModel({this.status, this.data});

  factory EditReviewByIdResponseModel.fromJson(String str) =>
      EditReviewByIdResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EditReviewByIdResponseModel.fromMap(Map<String, dynamic> json) =>
      EditReviewByIdResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {"status": status, "data": data?.toMap()};
}

class Data {
  final int? id;
  final int? userId;
  final int? eventId;
  final String? rating;
  final String? comment;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Data({
    this.id,
    this.userId,
    this.eventId,
    this.rating,
    this.comment,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    eventId: json["event_id"],
    rating: json["rating"],
    comment: json["comment"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "event_id": eventId,
    "rating": rating,
    "comment": comment,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
