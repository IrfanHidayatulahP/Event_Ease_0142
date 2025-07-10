import 'dart:convert';

class EditEventResponseModel {
  final String? status;
  final Data? data;

  EditEventResponseModel({this.status, this.data});

  factory EditEventResponseModel.fromJson(String str) =>
      EditEventResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EditEventResponseModel.fromMap(Map<String, dynamic> json) =>
      EditEventResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {"status": status, "data": data?.toMap()};
}

class Data {
  final String? nama;
  final String? deskripsi;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? lokasi;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Data({
    this.nama,
    this.deskripsi,
    this.startDate,
    this.endDate,
    this.lokasi,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    nama: json["nama"],
    deskripsi: json["deskripsi"],
    startDate:
        json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    lokasi: json["lokasi"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toMap() => {
    "nama": nama,
    "deskripsi": deskripsi,
    "start_date": startDate?.toIso8601String(),
    "end_date": endDate?.toIso8601String(),
    "lokasi": lokasi,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
