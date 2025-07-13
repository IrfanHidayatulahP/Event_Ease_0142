import 'dart:convert';

class GetImageByEventResponseModel {
  final String? status;
  final List<Image>? data;

  GetImageByEventResponseModel({this.status, this.data});

  factory GetImageByEventResponseModel.fromJson(String str) =>
      GetImageByEventResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetImageByEventResponseModel.fromMap(Map<String, dynamic> json) =>
      GetImageByEventResponseModel(
        status: json["status"],
        data:
            json["data"] == null
                ? []
                : List<Image>.from(json["data"]!.map((x) => Image.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Image {
  final int? id;
  final int? eventId;
  final String? image_path;

  Image({
    this.id,
    this.eventId,
    this.image_path,
  });

  factory Image.fromJson(String str) => Image.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Image.fromMap(Map<String, dynamic> json) => Image(
    id: json["id"],
    eventId: json["event_id"],
    image_path: json["image_path"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "event_id": eventId,
    "image_path": image_path
  };
}
