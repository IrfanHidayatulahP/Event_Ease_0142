import 'dart:convert';

class GetAllVirtualTicketsResponseModel {
  final String? status;
  final List<Datum>? data;

  GetAllVirtualTicketsResponseModel({this.status, this.data});

  factory GetAllVirtualTicketsResponseModel.fromJson(String str) =>
      GetAllVirtualTicketsResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllVirtualTicketsResponseModel.fromMap(
    Map<String, dynamic> json,
  ) => GetAllVirtualTicketsResponseModel(
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
  final int? orderId;
  final String? kode;
  final String? status;
  final DateTime? tanggal;

  Datum({this.id, this.orderId, this.kode, this.status, this.tanggal});

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
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
