import 'dart:convert';

class GetTicketByIdResponseModel {
  final String? status;
  final Data? data;

  GetTicketByIdResponseModel({this.status, this.data});

  factory GetTicketByIdResponseModel.fromJson(String str) =>
      GetTicketByIdResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetTicketByIdResponseModel.fromMap(Map<String, dynamic> json) =>
      GetTicketByIdResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {"status": status, "data": data?.toMap()};
}

class Data {
  final int? id;
  final int? eventId;
  final String? nama;
  final String? harga;
  final int? kuotaTotal;
  final int? kuotaTersedia;

  Data({
    this.id,
    this.eventId,
    this.nama,
    this.harga,
    this.kuotaTotal,
    this.kuotaTersedia,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    eventId: json["event_id"],
    nama: json["nama"],
    harga: json["harga"],
    kuotaTotal: json["kuota_total"],
    kuotaTersedia: json["kuota_tersedia"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "event_id": eventId,
    "nama": nama,
    "harga": harga,
    "kuota_total": kuotaTotal,
    "kuota_tersedia": kuotaTersedia,
  };
}
