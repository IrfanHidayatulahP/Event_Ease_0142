import 'dart:convert';

class EditReviewByIdRequestModel {
  final int? id;
  final int? userId;
  final int? eventId;
  final String? rating;
  final String? comment;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  EditReviewByIdRequestModel({
    this.id,
    this.userId,
    this.eventId,
    this.rating,
    this.comment,
    this.createdAt,
    this.updatedAt,
  });

  factory EditReviewByIdRequestModel.fromJson(String str) =>
      EditReviewByIdRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EditReviewByIdRequestModel.fromMap(
    Map<String, dynamic> json,
  ) => EditReviewByIdRequestModel(
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
