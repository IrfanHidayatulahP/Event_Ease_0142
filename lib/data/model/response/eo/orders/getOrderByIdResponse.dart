import 'dart:convert';

class GetOrderByIdResponseModel {
  final String? status;
  final Data? data;

  GetOrderByIdResponseModel({this.status, this.data});

  factory GetOrderByIdResponseModel.fromJson(String str) =>
      GetOrderByIdResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetOrderByIdResponseModel.fromMap(Map<String, dynamic> json) =>
      GetOrderByIdResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {"status": status, "data": data?.toMap()};
}

class Data {
  final int? id;
  final int? userId;
  final int? tiketKategoriId;
  final String? status;
  final int? jumlahTiket;
  final String? totalHarga;
  final DateTime? tanggalPemesanan;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Data({
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

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
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
