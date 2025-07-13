import 'dart:convert';

class EditImageRequestModel {
  final String? image_path;

  EditImageRequestModel({
    this.image_path,
  });

  factory EditImageRequestModel.fromJson(String str) =>
      EditImageRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EditImageRequestModel.fromMap(
    Map<String, dynamic> json,
  ) => EditImageRequestModel(
    image_path: json["image_path"],
  );

  Map<String, dynamic> toMap() => {
    "image_path": image_path,
  };
}
