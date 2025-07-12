import 'dart:convert';

class EditTicketByIdResponseModel {
  final String? status;
  final Edit? data;

  EditTicketByIdResponseModel({this.status, this.data});

  factory EditTicketByIdResponseModel.fromJson(String str) =>
      EditTicketByIdResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EditTicketByIdResponseModel.fromMap(Map<String, dynamic> json) =>
      EditTicketByIdResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : Edit.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {"status": status, "data": data?.toMap()};
}

class Edit {
  final int? id;
  final int? eventId;
  final String? nama;
  final String? harga;
  final int? kuotaTotal;
  final int? kuotaTersedia;

  Edit({
    this.id,
    this.eventId,
    this.nama,
    this.harga,
    this.kuotaTotal,
    this.kuotaTersedia,
  });

  factory Edit.fromJson(String str) => Edit.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Edit.fromMap(Map<String, dynamic> json) => Edit(
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
