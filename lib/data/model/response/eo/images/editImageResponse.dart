import 'dart:convert';

class EditImageResponseModel {
  final String? status;
  final Image? data;

  EditImageResponseModel({this.status, this.data});

  factory EditImageResponseModel.fromJson(String str) =>
      EditImageResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EditImageResponseModel.fromMap(Map<String, dynamic> json) =>
      EditImageResponseModel(
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
