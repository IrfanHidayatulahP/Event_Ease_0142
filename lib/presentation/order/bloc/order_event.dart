part of 'order_bloc.dart';

sealed class OrderEvent {}

class FetchOrderRequested extends OrderEvent {}

class FetchOrderByUserRequested extends OrderEvent {
  final int userId;

  FetchOrderByUserRequested(this.userId);
}

class AddOrderRequested extends OrderEvent {
  final AddOrderRequestModel request;
  AddOrderRequested({required this.request});
}

class UpdateOrderRequested extends OrderEvent {
  final int orderId;
  final int userId;
  final int tiketKategoriId;
  final String status;
  final int jumlahTiket;
  final double totalHarga;
  final DateTime tanggalPemesanan;

  UpdateOrderRequested(
    this.userId,
    this.tiketKategoriId,
    this.status,
    this.jumlahTiket,
    this.totalHarga,
    this.tanggalPemesanan, {
    required this.orderId,
  });
}

class UpdateOrderStatusRequested extends OrderEvent {
  final int orderId;
  final String newStatus;

  UpdateOrderStatusRequested({required this.orderId, required this.newStatus});
}

class DeleteOrderRequested extends OrderEvent {
  final String orderId;
  DeleteOrderRequested({required this.orderId});
}
