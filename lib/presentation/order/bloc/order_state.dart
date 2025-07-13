part of 'order_bloc.dart';

sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderLoadSuccess extends OrderState {
  final List<Order> orders;
  OrderLoadSuccess(this.orders);
}

final class OrderLoadByUserSuccess extends OrderState {
  final List<History> hist;
  OrderLoadByUserSuccess(this.hist);
}

final class OrderUpdateSuccess extends OrderState {
  final Order editOrder;
  OrderUpdateSuccess(this.editOrder);
}

final class OrderDeleteSuccess extends OrderState {
  final String deletedId;
  OrderDeleteSuccess(this.deletedId);
}

final class OrderFailure extends OrderState {
  final String error;
  OrderFailure(this.error);
}
