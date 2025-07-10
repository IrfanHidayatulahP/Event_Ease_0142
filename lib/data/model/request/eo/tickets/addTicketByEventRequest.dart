import 'dart:convert';

class AddTicketByEventRequestModel {
    final int? eventId;
    final String? nama;
    final String? harga;
    final int? kuotaTotal;
    final int? kuotaTersedia;

    AddTicketByEventRequestModel({
        this.eventId,
        this.nama,
        this.harga,
        this.kuotaTotal,
        this.kuotaTersedia,
    });

    factory AddTicketByEventRequestModel.fromJson(String str) => AddTicketByEventRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AddTicketByEventRequestModel.fromMap(Map<String, dynamic> json) => AddTicketByEventRequestModel(
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
