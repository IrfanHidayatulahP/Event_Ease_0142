part of 'event_bloc.dart';

abstract class EventEvent {}

// fetch all
class FetchEventsRequested extends EventEvent {}

// add new
class AddEventRequested extends EventEvent {
  final AddEventRequest request;
  AddEventRequested({required this.request});
}
