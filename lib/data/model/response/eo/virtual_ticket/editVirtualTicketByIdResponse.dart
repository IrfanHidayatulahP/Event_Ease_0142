import 'dart:convert';

class EditVirtualTicketByIdResponseModel {
  final String? status;
  final Data? data;

  EditVirtualTicketByIdResponseModel({this.status, this.data});

  factory EditVirtualTicketByIdResponseModel.fromJson(String str) =>
      EditVirtualTicketByIdResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EditVirtualTicketByIdResponseModel.fromMap(
    Map<String, dynamic> json,
  ) => EditVirtualTicketByIdResponseModel(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {"status": status, "data": data?.toMap()};
}

class Data {
  final int? id;
  final int? orderId;
  final String? kode;
  final String? status;
  final DateTime? tanggal;

  Data({this.id, this.orderId, this.kode, this.status, this.tanggal});

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    orderId: json["order_id"],
    kode: json["kode"],
    status: json["status"],
    tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "order_id": orderId,
    "kode": kode,
    "status": status,
    "tanggal":
        "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
  };
}
