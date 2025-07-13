import 'package:bloc/bloc.dart';
import 'package:event_ease/data/model/request/eo/orders/addOrderRequest.dart';
import 'package:event_ease/data/model/request/eo/orders/editOrderRequest.dart';
import 'package:event_ease/data/model/response/eo/orders/getAllOrdersResponse.dart';
import 'package:event_ease/data/model/response/eo/orders/getOrderByUserIdResponse.dart';
import 'package:event_ease/data/repository/orderRepository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository repo;

  OrderBloc(this.repo) : super(OrderInitial()) {
    on<FetchOrderRequested>(_onFetch);
    on<FetchOrderByUserRequested>(_onFetchUser);
    on<AddOrderRequested>(_onAdd);
    on<UpdateOrderRequested>(_onUpdate);
    on<UpdateOrderStatusRequested>(_onUpdateStatus);
    on<DeleteOrderRequested>(_onDelete);
  }

  Future<void> _onFetch(
    FetchOrderRequested event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    final result = await repo.fetchOrders();
    result.fold(
      (failure) => emit(OrderFailure(failure)),
      (response) => emit(OrderLoadSuccess(response.data ?? [])),
    );
  }

  Future<void> _onFetchUser(
    FetchOrderByUserRequested event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    final result = await repo.fetchOrderByUserId(event.userId.toString());
    result.fold(
      (failure) => emit(OrderFailure(failure)),
      (response) => emit(OrderLoadByUserSuccess(response.data ?? [])),
    );
  }

  Future<void> _onAdd(AddOrderRequested event, Emitter<OrderState> emit) async {
    emit(OrderLoading());

    final result = await repo.addOrder(event.request);

    result.fold((failure) => emit(OrderFailure(failure)), (response) {
      // Optional: bisa emit success atau langsung fetch ulang
      add(FetchOrderByUserRequested(event.request.userId!));
    });
  }

  Future<void> _onUpdate(
    UpdateOrderRequested event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());

    // Buat request edit berdasarkan model yang benar
    final req = EditOrderRequestModel(
      userId: event.userId,
      tiketKategoriId: event.tiketKategoriId,
      jumlahTiket: event.jumlahTiket,
      tanggalPemesanan: event.tanggalPemesanan,
      status: event.status,
      totalHarga: event.totalHarga.toString(),
    );

    // Panggil updateOrder dengan EditOrderRequestModel, bukan cast aneh‑aneh
    final result = await repo.updateOrder(event.orderId.toString(), req);

    result.fold(
      (failure) {
        emit(OrderFailure(failure));
      },
      (response) {
        final d = response.data!;
        final updatedOrder = Order(
          id: d.id,
          userId: d.userId,
          tiketKategoriId: d.tiketKategoriId,
          jumlahTiket: d.jumlahTiket,
          totalHarga: d.totalHarga,
          tanggalPemesanan: d.tanggalPemesanan,
          status: d.status,
        );

        emit(OrderUpdateSuccess(updatedOrder));
      },
    );
  }

  Future<void> _onUpdateStatus(
    UpdateOrderStatusRequested event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());

    final existingResult = await repo.fetchOrderById(event.orderId.toString());

    await existingResult.fold((failure) async => emit(OrderFailure(failure)), (
      orderData,
    ) async {
      final data = orderData.data!;
      final updatedReq = EditOrderRequestModel(
        userId: data.userId!,
        tiketKategoriId: data.tiketKategoriId!,
        jumlahTiket: data.jumlahTiket!,
        totalHarga: data.totalHarga!.toString(),
        tanggalPemesanan: data.tanggalPemesanan!,
        status: event.newStatus,
      );

      final updateResult = await repo.updateOrder(
        event.orderId.toString(),
        updatedReq,
      );

      updateResult.fold((failure) => emit(OrderFailure(failure)), (res) {
        final d = res.data!;
        emit(
          OrderUpdateSuccess(
            Order(
              id: d.id,
              userId: d.userId,
              tiketKategoriId: d.tiketKategoriId,
              jumlahTiket: d.jumlahTiket,
              totalHarga: d.totalHarga,
              tanggalPemesanan: d.tanggalPemesanan,
              status: d.status,
            ),
          ),
        );
      });
    });
  }

  Future<void> _onDelete(
    DeleteOrderRequested event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    final result = await repo.deleteOrder(event.orderId);
    result.fold((failure) => emit(OrderFailure(failure)), (_) {
      emit(OrderDeleteSuccess(event.orderId));
      // fetch ulang setelah delete
      add(FetchOrderRequested());
    });
  }
}
