import 'dart:convert';

class EditVirtualTicketByIdRequestModel {
  final int? orderId;
  final String? kode;
  final String? status;
  final DateTime? tanggal;

  EditVirtualTicketByIdRequestModel({
    this.orderId,
    this.kode,
    this.status,
    this.tanggal,
  });

  factory EditVirtualTicketByIdRequestModel.fromJson(String str) =>
      EditVirtualTicketByIdRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EditVirtualTicketByIdRequestModel.fromMap(
    Map<String, dynamic> json,
  ) => EditVirtualTicketByIdRequestModel(
    orderId: json["order_id"],
    kode: json["kode"],
    status: json["status"],
    tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
  );

  Map<String, dynamic> toMap() => {
    "order_id": orderId,
    "kode": kode,
    "status": status,
    "tanggal":
        "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
  };
}
