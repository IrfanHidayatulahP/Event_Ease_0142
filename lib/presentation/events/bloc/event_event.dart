part of 'event_bloc.dart';

abstract class EventEvent {}

// fetch all
class FetchEventsRequested extends EventEvent {}

// add new
class AddEventRequested extends EventEvent {
  final AddEventRequest request;
  AddEventRequested({required this.request});
}

// update existing
class UpdateEventRequested extends EventEvent {
  final String eventId;
  final String nama;
  final String deskripsi;
  final DateTime startDate;
  final DateTime endDate;
  final String lokasi;

  UpdateEventRequested(
    this.nama,
    this.deskripsi,
    this.startDate,
    this.endDate,
    this.lokasi, {
    required this.eventId,
  });
}

class DeleteEventRequested extends EventEvent {
  final String eventId;
  DeleteEventRequested({required this.eventId});
}
