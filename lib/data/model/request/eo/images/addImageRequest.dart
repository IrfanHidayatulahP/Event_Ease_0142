import 'dart:convert';

class AddImageRequest {
  final String? image_path;

  AddImageRequest({
    this.image_path
  });

  factory AddImageRequest.fromJson(String str) =>
      AddImageRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddImageRequest.fromMap(Map<String, dynamic> json) => AddImageRequest(
    image_path: json["image_path"],
  );

  Map<String, dynamic> toMap() => {
    "image_path": image_path,
  };
}

