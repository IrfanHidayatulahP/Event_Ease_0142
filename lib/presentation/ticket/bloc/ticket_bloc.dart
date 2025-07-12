import 'package:bloc/bloc.dart';
import 'package:event_ease/data/model/request/eo/tickets/editTicketByIdRequest.dart';
import 'package:event_ease/data/model/response/eo/tickets/addTicketByEventResponse.dart';
import 'package:event_ease/data/model/response/eo/tickets/editTicketByIdResponse.dart';
import 'package:event_ease/data/model/response/eo/tickets/getTicketByEventResponse.dart';
import 'package:event_ease/data/repository/ticketRepository.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final TicketRepository repo;

  TicketBloc(this.repo) : super(TicketInitial()) {
    on<FetchTicketRequest>(_onFetch);
    on<AddTicketRequested>(_onAdd);
    on<UpdateTicketRequested>(_onUpdate);
    on<DeleteTicketRequested>(_onDelete);
  }

  Future<void> _onFetch(
    FetchTicketRequest evt,
    Emitter<TicketState> emit,
  ) async {
    emit(TicketLoading());
    final result = await repo.fetchTickets(evt.eventId);
    result.fold(
      (l) => emit(TicketFailure(l)),
      (r) => emit(TicketLoadSuccess(r.data ?? [])),
    );
  }

  Future<void> _onAdd(
    AddTicketRequested ticket,
    Emitter<TicketState> emit,
  ) async {
    emit(TicketLoading());
    final result = await repo.addTicket(
      ticket.request as AddTicketByEventResponseModel,
    );
    result.fold((l) => emit(TicketFailure(l)), (r) {
      final newDatum = Datum(
        id: r.data?.id,
        eventId: r.data?.eventId,
        nama: r.data?.nama,
        harga: r.data?.harga,
        kuotaTotal: r.data?.kuotaTotal,
        kuotaTersedia: r.data?.kuotaTersedia,
      );
      emit(TicketAddSuccess(newDatum));
      add(FetchTicketRequest(r.data?.eventId as String));
    });
  }

  Future<void> _onUpdate(
    UpdateTicketRequested ticket,
    Emitter<TicketState> emit,
  ) async {
    emit(TicketLoading());

    final req = EditTicketByIdRequestModel(
      eventId: ticket.eventId,
      nama: ticket.nama,
      harga: ticket.harga.toString(),
      kuotaTotal: ticket.kuota,
      kuotaTersedia: ticket.kuotaTersedia,
    );

    final result = await repo.updateTicket(
      ticket.ticketId.toString(),
      req as EditTicketByIdResponseModel,
    );

    result.fold(
      (failure) {
        emit(TicketFailure(failure));
      },
      (response) {
        final d = response.data!;
        final updateTicket = Datum(
          id: d.id,
          eventId: d.eventId,
          nama: d.nama,
          harga: d.harga,
          kuotaTotal: d.kuotaTotal,
          kuotaTersedia: d.kuotaTersedia,
        );
        emit(TicketUpdateSuccess(updateTicket));
      },
    );
  }

  Future<void> _onDelete(
    DeleteTicketRequested ticket,
    Emitter<TicketState> emit,
  ) async {
    emit(TicketLoading());
    final result = await repo.deleteTicket(ticket.ticketId);
    result.fold((failure) => emit(TicketFailure(failure)), (_) {
      emit(TicketDeleteSuccess(ticket.ticketId));
      add(FetchTicketRequest(ticket.ticketId));
    });
  }
}
