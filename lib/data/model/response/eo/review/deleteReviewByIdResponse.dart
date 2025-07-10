import 'dart:convert';

class DeleteReviewByIdResponseModel {
  final String? status;
  final String? message;

  DeleteReviewByIdResponseModel({this.status, this.message});

  factory DeleteReviewByIdResponseModel.fromJson(String str) =>
      DeleteReviewByIdResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeleteReviewByIdResponseModel.fromMap(Map<String, dynamic> json) =>
      DeleteReviewByIdResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {"status": status, "message": message};
}
