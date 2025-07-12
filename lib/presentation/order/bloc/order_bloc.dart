import 'package:bloc/bloc.dart';
import 'package:event_ease/data/model/request/eo/orders/addOrderRequest.dart';
import 'package:event_ease/data/model/request/eo/orders/editOrderRequest.dart';
import 'package:event_ease/data/model/response/eo/orders/getAllOrdersResponse.dart';
import 'package:event_ease/data/repository/orderRepository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository repo;

  OrderBloc(this.repo) : super(OrderInitial()) {
    on<FetchOrderRequested>(_onFetch);
    on<UpdateOrderRequested>(_onUpdate);
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

  Future<void> _onUpdate(
    UpdateOrderRequested event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());

    final req = EditOrderRequestModel(
      userId: event.userId,
      tiketKategoriId: event.tiketKategoriId,
      jumlahTiket: event.jumlahTiket,
      tanggalPemesanan: event.tanggalPemesanan,
      status: event.status,
      totalHarga: event.totalHarga.toString(),
    );

    final result = await repo.updateOrder(event.orderId.toString(), req as AddOrderRequestModel);
    result.fold(
      (failure) => emit(OrderFailure(failure)),
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
        // fetch ulang setelah update
        add(FetchOrderRequested());
      },
    );
  }

  Future<void> _onDelete(
    DeleteOrderRequested event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    final result = await repo.deleteOrder(event.orderId);
    result.fold(
      (failure) => emit(OrderFailure(failure)),
      (_) {
        emit(OrderDeleteSuccess(event.orderId));
        // fetch ulang setelah delete
        add(FetchOrderRequested());
      },
    );
  }
}
