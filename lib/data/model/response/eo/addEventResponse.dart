import 'dart:convert';

class AddEventResponse {
  final String? status;
  final Data? data;

  AddEventResponse({this.status, this.data});

  factory AddEventResponse.fromJson(String str) =>
      AddEventResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddEventResponse.fromMap(Map<String, dynamic> json) =>
      AddEventResponse(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {"status": status, "data": data?.toMap()};
}

class Data {
  final int? id;
  final String? nama;
  final String? deskripsi;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? lokasi;
  final DateTime? createdAt;

  Data({
    this.id,
    this.nama,
    this.deskripsi,
    this.startDate,
    this.endDate,
    this.lokasi,
    this.createdAt,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    nama: json["nama"],
    deskripsi: json["deskripsi"],
    startDate:
        json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    lokasi: json["lokasi"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nama": nama,
    "deskripsi": deskripsi,
    "start_date": startDate?.toIso8601String(),
    "end_date": endDate?.toIso8601String(),
    "lokasi": lokasi,
    "createdAt": createdAt?.toIso8601String(),
  };
}
