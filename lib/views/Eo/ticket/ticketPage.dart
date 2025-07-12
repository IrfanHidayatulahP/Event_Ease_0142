import 'package:event_ease/data/model/response/eo/tickets/getTicketByEventResponse.dart';
import 'package:event_ease/presentation/ticket/bloc/ticket_bloc.dart';
import 'package:event_ease/views/Eo/ticket/editTicketPage.dart';
import 'package:event_ease/views/eo/ticket/addTicketPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketPage extends StatefulWidget {
  final int eventId;
  const TicketPage({super.key, required this.eventId});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  @override
  void initState() {
    super.initState();
    context.read<TicketBloc>().add(
      FetchTicketRequest(widget.eventId.toString()),
    );
  }

  void _deleteTicket(Datum ticket) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Hapus Tiket'),
            content: Text(
              'Apakah kamu yakin ingin menghapus tiket "${ticket.nama}"?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx); // Tutup dialog
                  context.read<TicketBloc>().add(
                    DeleteTicketRequested(
                      ticketId: ticket.id.toString(),
                      eventId: widget.eventId.toString(),
                    ),
                  );
                },
                child: const Text('Hapus'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tickets for Event #${widget.eventId}')),
      body: BlocBuilder<TicketBloc, TicketState>(
        builder: (context, state) {
          if (state is TicketLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TicketLoadSuccess) {
            final tickets = state.ticket;
            if (tickets.isEmpty) {
              return const Center(child: Text('No tickets available.'));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: tickets.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (ctx, i) {
                final t = tickets[i];
                return ListTile(
                  title: Text(t.nama ?? '-'),
                  subtitle: Text(
                    'Price: ${t.harga} | Available: ${t.kuotaTersedia}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          final updatedTicket = await Navigator.push<Datum>(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => BlocProvider.value(
                                    value: context.read<TicketBloc>(),
                                    child: EditTicketPage(ticket: t),
                                  ),
                            ),
                          );
                          if (updatedTicket != null) {
                            context.read<TicketBloc>().add(
                              FetchTicketRequest(widget.eventId.toString()),
                            );
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteTicket(t),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is TicketFailure) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTicket = await Navigator.push<Datum>(
            context,
            MaterialPageRoute(
              builder:
                  (_) => BlocProvider.value(
                    value: context.read<TicketBloc>(),
                    child: AddTicketPage(eventId: widget.eventId),
                  ),
            ),
          );
          if (newTicket != null) {
            context.read<TicketBloc>().add(
              FetchTicketRequest(widget.eventId.toString()),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
