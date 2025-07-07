import 'dart:convert';

class EventResponseModel {
  final String? status;
  final List<Datum>? data;

  EventResponseModel({this.status, this.data});

  factory EventResponseModel.fromJson(String str) =>
      EventResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EventResponseModel.fromMap(Map<String, dynamic> json) =>
      EventResponseModel(
        status: json["status"],
        data:
            json["data"] == null
                ? []
                : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
  final int? id;
  final String? nama;
  final String? deskripsi;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? lokasi;
  final dynamic createdAt;

  Datum({
    this.id,
    this.nama,
    this.deskripsi,
    this.startDate,
    this.endDate,
    this.lokasi,
    this.createdAt,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    nama: json["nama"],
    deskripsi: json["deskripsi"],
    startDate:
        json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    lokasi: json["lokasi"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nama": nama,
    "deskripsi": deskripsi,
    "start_date": startDate?.toIso8601String(),
    "end_date": endDate?.toIso8601String(),
    "lokasi": lokasi,
    "createdAt": createdAt,
  };
}
