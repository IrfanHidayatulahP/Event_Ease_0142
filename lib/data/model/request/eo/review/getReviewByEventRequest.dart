import 'dart:convert';

class GetReviewByEventRequest {
  final int? eventId;

  GetReviewByEventRequest({this.eventId});

  factory GetReviewByEventRequest.fromJson(String str) =>
      GetReviewByEventRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetReviewByEventRequest.fromMap(Map<String, dynamic> json) =>
      GetReviewByEventRequest(eventId: json["event_id"]);

  Map<String, dynamic> toMap() => {"event_id": eventId};
}
