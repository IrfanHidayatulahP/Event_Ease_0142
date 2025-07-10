import 'dart:convert';

class EditOrderRequestModel {
  final int? userId;
  final int? tiketKategoriId;
  final String? status;
  final int? jumlahTiket;
  final String? totalHarga;
  final DateTime? tanggalPemesanan;

  EditOrderRequestModel({
    this.userId,
    this.tiketKategoriId,
    this.status,
    this.jumlahTiket,
    this.totalHarga,
    this.tanggalPemesanan,
  });

  factory EditOrderRequestModel.fromJson(String str) =>
      EditOrderRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EditOrderRequestModel.fromMap(Map<String, dynamic> json) =>
      EditOrderRequestModel(
        userId: json["user_id"],
        tiketKategoriId: json["tiket_kategori_id"],
        status: json["status"],
        jumlahTiket: json["jumlah_tiket"],
        totalHarga: json["total_harga"],
        tanggalPemesanan:
            json["tanggal_pemesanan"] == null
                ? null
                : DateTime.parse(json["tanggal_pemesanan"]),
      );

  Map<String, dynamic> toMap() => {
    "user_id": userId,
    "tiket_kategori_id": tiketKategoriId,
    "status": status,
    "jumlah_tiket": jumlahTiket,
    "total_harga": totalHarga,
    "tanggal_pemesanan":
        "${tanggalPemesanan!.year.toString().padLeft(4, '0')}-${tanggalPemesanan!.month.toString().padLeft(2, '0')}-${tanggalPemesanan!.day.toString().padLeft(2, '0')}",
  };
}
