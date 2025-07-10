import 'dart:convert';

class EditTicketByIdRequestModel {
  final int? eventId;
  final String? nama;
  final String? harga;
  final int? kuotaTotal;
  final int? kuotaTersedia;

  EditTicketByIdRequestModel({
    this.eventId,
    this.nama,
    this.harga,
    this.kuotaTotal,
    this.kuotaTersedia,
  });

  factory EditTicketByIdRequestModel.fromJson(String str) =>
      EditTicketByIdRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EditTicketByIdRequestModel.fromMap(Map<String, dynamic> json) =>
      EditTicketByIdRequestModel(
        eventId: json["event_id"],
        nama: json["nama"],
        harga: json["harga"],
        kuotaTotal: json["kuota_total"],
        kuotaTersedia: json["kuota_tersedia"],
      );

  Map<String, dynamic> toMap() => {
    "event_id": eventId,
    "nama": nama,
    "harga": harga,
    "kuota_total": kuotaTotal,
    "kuota_tersedia": kuotaTersedia,
  };
}
