import 'dart:convert';

class GetReviewByEventResponseModel {
  final String? status;
  final List<Datum>? data;

  GetReviewByEventResponseModel({this.status, this.data});

  factory GetReviewByEventResponseModel.fromJson(String str) =>
      GetReviewByEventResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetReviewByEventResponseModel.fromMap(Map<String, dynamic> json) =>
      GetReviewByEventResponseModel(
        status: json["status"],
        data:
            json["data"] == null
                ? []
                : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
  final int? id;
  final int? userId;
  final int? eventId;
  final String? rating;
  final String? comment;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Datum({
    this.id,
    this.userId,
    this.eventId,
    this.rating,
    this.comment,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
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
