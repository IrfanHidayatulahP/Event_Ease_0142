import 'dart:convert';

class GetAllOrderResponseModel {
  final String? status;
  final List<Order>? data;

  GetAllOrderResponseModel({this.status, this.data});

  factory GetAllOrderResponseModel.fromJson(String str) =>
      GetAllOrderResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllOrderResponseModel.fromMap(Map<String, dynamic> json) =>
      GetAllOrderResponseModel(
        status: json["status"],
        data:
            json["data"] == null
                ? []
                : List<Order>.from(json["data"]!.map((x) => Order.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Order {
  final int? id;
  final int? userId;
  final int? tiketKategoriId;
  final String? status;
  final int? jumlahTiket;
  final String? totalHarga;
  final DateTime? tanggalPemesanan;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Order({
    this.id,
    this.userId,
    this.tiketKategoriId,
    this.status,
    this.jumlahTiket,
    this.totalHarga,
    this.tanggalPemesanan,
    this.createdAt,
    this.updatedAt,
  });

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
    id: json["id"],
    userId: json["user_id"],
    tiketKategoriId: json["tiket_kategori_id"],
    status: json["status"],
    jumlahTiket: json["jumlah_tiket"],
    totalHarga: json["total_harga"],
    tanggalPemesanan:
        json["tanggal_pemesanan"] == null
            ? null
            : DateTime.parse(json["tanggal_pemesanan"]),
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "tiket_kategori_id": tiketKategoriId,
    "status": status,
    "jumlah_tiket": jumlahTiket,
    "total_harga": totalHarga,
    "tanggal_pemesanan":
        "${tanggalPemesanan!.year.toString().padLeft(4, '0')}-${tanggalPemesanan!.month.toString().padLeft(2, '0')}-${tanggalPemesanan!.day.toString().padLeft(2, '0')}",
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
