part of 'event_bloc.dart';

sealed class EventState {}

/// Awal / loading idle
final class EventInitial extends EventState {}

/// Sedang memuat data atau menambahkan event
final class EventLoading extends EventState {}

/// Data events berhasil di-fetch
final class EventLoadSuccess extends EventState {
  final List<Datum> events;
  EventLoadSuccess(this.events);
}

/// Event baru berhasil ditambahkan
final class EventAddSuccess extends EventState {
  final Datum newEvent;
  EventAddSuccess(this.newEvent);
}

/// Event berhasil di-update
final class EventUpdateSuccess extends EventState {
  final Datum editEvent;
  EventUpdateSuccess(this.editEvent);
}


/// Terjadi error pada fetch atau add
final class EventFailure extends EventState {
  final String error;
  EventFailure(this.error);
}
