import 'dart:convert';

class AddReviewByEventResponseModel {
  final String? status;
  final Data? data;

  AddReviewByEventResponseModel({this.status, this.data});

  factory AddReviewByEventResponseModel.fromJson(String str) =>
      AddReviewByEventResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddReviewByEventResponseModel.fromMap(Map<String, dynamic> json) =>
      AddReviewByEventResponseModel(
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
  final DateTime? updatedAt;
  final DateTime? createdAt;

  Data({
    this.id,
    this.userId,
    this.eventId,
    this.rating,
    this.comment,
    this.updatedAt,
    this.createdAt,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    eventId: json["event_id"],
    rating: json["rating"],
    comment: json["comment"],
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "event_id": eventId,
    "rating": rating,
    "comment": comment,
    "updatedAt": updatedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
  };
}
