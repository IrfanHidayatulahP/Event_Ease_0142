part of 'event_bloc.dart';

sealed class EventEvent {}

/// Minta load semua data Event EO
final class FetchEventsRequested extends EventEvent {}

/// Minta tambah event baru dengan payload [request]
final class AddEventRequested extends EventEvent {
  final AddEventRequest request;
  AddEventRequested(this.request);
}
