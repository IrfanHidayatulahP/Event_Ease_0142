import 'dart:convert';

class AddImageResponseModel {
  final String? status;
  final Image? data;

  AddImageResponseModel({this.status, this.data});

  factory AddImageResponseModel.fromJson(String str) =>
      AddImageResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddImageResponseModel.fromMap(Map<String, dynamic> json) =>
      AddImageResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : Image.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {"status": status, "data": data?.toMap()};
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
