part of 'ticket_bloc.dart';

sealed class TicketEvent {}

class FetchTicketRequest extends TicketEvent {
  final String eventId;
  FetchTicketRequest(this.eventId);
}

class AddTicketRequested extends TicketEvent {
  final AddTicketRequested request;
  AddTicketRequested(this.request);
}

class UpdateTicketRequested extends TicketEvent {
  final int ticketId;
  final int eventId;
  final String nama;
  final double harga;
  final int kuota;
  final int kuotaTersedia;

  UpdateTicketRequested(
    this.eventId,
    this.nama,
    this.harga,
    this.kuota,
    this.kuotaTersedia, {
    required this.ticketId,
  });
}

class DeleteTicketRequested extends TicketEvent {
  final String ticketId;
  DeleteTicketRequested({required this.ticketId});
}
