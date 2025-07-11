import 'package:bloc/bloc.dart';
import 'package:event_ease/data/model/request/eo/event/addEventRequest.dart';
import 'package:event_ease/data/model/request/eo/event/editEventRequest.dart';
import 'package:event_ease/data/model/response/eo/event/getEventResponse.dart';
import 'package:event_ease/data/repository/eventRepository.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository repo;

  EventBloc(this.repo) : super(EventInitial()) {
    on<FetchEventsRequested>(_onFetch);
    on<AddEventRequested>(_onAdd);
    on<UpdateEventRequested>(_onUpdate);
    on<DeleteEventRequested>(_onDelete);
  }

  Future<void> _onFetch(
    FetchEventsRequested event,
    Emitter<EventState> emit,
  ) async {
    emit(EventLoading());
    final result = await repo.fetchEvents();
    result.fold(
      (l) => emit(EventFailure(l)),
      (r) => emit(EventLoadSuccess(r.data ?? [])),
    );
  }

  Future<void> _onAdd(AddEventRequested event, Emitter<EventState> emit) async {
    emit(EventLoading());
    final result = await repo.addEvent(event.request);
    result.fold((l) => emit(EventFailure(l)), (r) {
      final newDatum = Datum(
        id: r.data?.id,
        nama: r.data?.nama,
        deskripsi: r.data?.deskripsi,
        startDate: r.data?.startDate,
        endDate: r.data?.endDate,
        lokasi: r.data?.lokasi,
        createdAt: r.data?.createdAt,
      );
      emit(EventAddSuccess(newDatum));
      add(FetchEventsRequested());
    });
  }

  Future<void> _onUpdate(
    UpdateEventRequested event,
    Emitter<EventState> emit,
  ) async {
    emit(EventLoading());

    final req = EditEventRequestModel(
      nama: event.nama,
      deskripsi: event.deskripsi,
      startDate: event.startDate,
      endDate: event.endDate,
      lokasi: event.lokasi,
    );

    final result = await repo.updateEvent(event.eventId, req);

    result.fold((l) => emit(EventFailure(l)), (r) {
      // r is EditEventResponseModel
      final d = r.data!;
      final updatedDatum = Datum(
        id: int.parse(event.eventId),
        nama: d.nama,
        deskripsi: d.deskripsi,
        startDate: d.startDate,
        endDate: d.endDate,
        lokasi: d.lokasi,
        createdAt: event.startDate,
      );

      emit(EventUpdateSuccess(updatedDatum));
      add(FetchEventsRequested());
    });
  }

  Future<void> _onDelete(
    DeleteEventRequested event,
    Emitter<EventState> emit,
  ) async {
    emit(EventLoading());
    final result = await repo.deleteEvent(event.eventId);
    result.fold((l) => emit(EventFailure(l)), (r) {
      emit(EventDeleteSuccess(event.eventId));
      add(FetchEventsRequested());
    });
  }
}
