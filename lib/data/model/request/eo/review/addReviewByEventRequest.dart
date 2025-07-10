import 'dart:convert';

class AddReviewByEventRequestModel {
  final int? userId;
  final int? eventId;
  final String? rating;
  final String? comment;

  AddReviewByEventRequestModel({
    this.userId,
    this.eventId,
    this.rating,
    this.comment,
  });

  factory AddReviewByEventRequestModel.fromJson(String str) =>
      AddReviewByEventRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddReviewByEventRequestModel.fromMap(Map<String, dynamic> json) =>
      AddReviewByEventRequestModel(
        userId: json["user_id"],
        eventId: json["event_id"],
        rating: json["rating"],
        comment: json["comment"],
      );

  Map<String, dynamic> toMap() => {
    "user_id": userId,
    "event_id": eventId,
    "rating": rating,
    "comment": comment,
  };
}
