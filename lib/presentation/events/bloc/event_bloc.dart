import 'package:bloc/bloc.dart';
import 'package:event_ease/data/model/request/eo/event/addEventRequest.dart';
import 'package:event_ease/data/model/response/eo/event/getEventResponse.dart';
import 'package:event_ease/data/repository/eventRepository.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository repo;

  EventBloc(this.repo) : super(EventInitial()) {
    on<FetchEventsRequested>(_onFetch);
    on<AddEventRequested>(_onAdd);
  }

  Future<void> _onFetch(
    FetchEventsRequested event,
    Emitter<EventState> emit,
  ) async {
    emit(EventLoading());
    final result = await repo.fetchEvents();
    result.fold(
      (l) => emit(EventFailure(l)),
      (r) => emit(EventLoadSuccess(r.data ?? [])), // ✅ ambil list event-nya
    );
  }

  Future<void> _onAdd(AddEventRequested event, Emitter<EventState> emit) async {
    emit(EventLoading());
    final result = await repo.addEvent(event.request);
    result.fold((l) => emit(EventFailure(l)), (r) {
      // r is AddEventResponse
      final addData = r;
      // map AddEventResponse.Data → Datum
      final newDatum = Datum(
        id: addData.data?.id,
        nama: addData.data?.nama,
        deskripsi: addData.data?.deskripsi,
        startDate: addData.data?.startDate,
        endDate: addData.data?.endDate,
        lokasi: addData.data?.lokasi,
        createdAt: addData.data?.createdAt, // dynamic in Datum
      );

      emit(EventAddSuccess(newDatum));

      // reload list
      add(FetchEventsRequested());
    });
  }
}
