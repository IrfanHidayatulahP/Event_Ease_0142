import 'dart:convert';

class AddTicketByEventResponseModel {
  final String? status;
  final Ticket? data;

  AddTicketByEventResponseModel({this.status, this.data});

  factory AddTicketByEventResponseModel.fromJson(String str) =>
      AddTicketByEventResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddTicketByEventResponseModel.fromMap(Map<String, dynamic> json) =>
      AddTicketByEventResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : Ticket.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {"status": status, "data": data?.toMap()};
}

class Ticket {
  final int? id;
  final int? eventId;
  final String? nama;
  final String? harga;
  final int? kuotaTotal;
  final int? kuotaTersedia;

  Ticket({
    this.id,
    this.eventId,
    this.nama,
    this.harga,
    this.kuotaTotal,
    this.kuotaTersedia,
  });

  factory Ticket.fromJson(String str) => Ticket.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ticket.fromMap(Map<String, dynamic> json) => Ticket(
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
