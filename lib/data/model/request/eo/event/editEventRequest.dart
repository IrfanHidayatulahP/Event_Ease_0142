import 'dart:convert';

class EditEventRequestModel {
  final String? nama;
  final String? deskripsi;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? lokasi;

  EditEventRequestModel({
    this.nama,
    this.deskripsi,
    this.startDate,
    this.endDate,
    this.lokasi,
  });

  factory EditEventRequestModel.fromJson(String str) =>
      EditEventRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EditEventRequestModel.fromMap(
    Map<String, dynamic> json,
  ) => EditEventRequestModel(
    nama: json["nama"],
    deskripsi: json["deskripsi"],
    startDate:
        json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    lokasi: json["lokasi"],
  );

  Map<String, dynamic> toMap() => {
    "nama": nama,
    "deskripsi": deskripsi,
    "start_date":
        "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date":
        "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "lokasi": lokasi,
  };
}
