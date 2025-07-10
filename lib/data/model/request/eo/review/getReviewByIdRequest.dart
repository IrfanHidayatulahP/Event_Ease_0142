import 'dart:convert';

class GetReviewByIdrequest {
  final int? reviewId;

  GetReviewByIdrequest({this.reviewId});

  factory GetReviewByIdrequest.fromJson(String str) =>
      GetReviewByIdrequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetReviewByIdrequest.fromMap(Map<String, dynamic> json) =>
      GetReviewByIdrequest(reviewId: json["review_id"]);

  Map<String, dynamic> toMap() => {"review_id": reviewId};
}
