part of 'ticket_bloc.dart';

sealed class TicketState {}

final class TicketInitial extends TicketState {}

final class TicketLoading extends TicketState {}

final class TicketLoadSuccess extends TicketState {
  final List<Datum> ticket;
  TicketLoadSuccess(this.ticket);
}

final class TicketAddSuccess extends TicketState {
  final Datum newTicket;
  TicketAddSuccess(this.newTicket);
}

final class TicketUpdateSuccess extends TicketState {
  final Datum editTicket;
  TicketUpdateSuccess(this.editTicket);
}

final class TicketDeleteSuccess extends TicketState {
  final String deletedId;
  TicketDeleteSuccess(this.deletedId);
}

final class TicketFailure extends TicketState {
  final String error;
  TicketFailure(this.error);
}
