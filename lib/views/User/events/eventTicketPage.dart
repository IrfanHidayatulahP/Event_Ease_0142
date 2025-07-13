import 'package:event_ease/data/model/auth/loginResponse.dart';
import 'package:event_ease/data/model/response/eo/event/getEventResponse.dart';
import 'package:event_ease/presentation/ticket/bloc/ticket_bloc.dart';
import 'package:event_ease/views/User/events/bookingEventPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventTicketPage extends StatefulWidget {
  final int eventId;
  final Data user;
  final Datum event;

  const EventTicketPage({
    super.key,
    required this.eventId,
    required this.user,
    required this.event,
  });

  @override
  State<EventTicketPage> createState() => _EventTicketPageState();
}

class _EventTicketPageState extends State<EventTicketPage> {
  @override
  void initState() {
    super.initState();
    context.read<TicketBloc>().add(
      FetchTicketRequest(widget.eventId.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ticket Event ${widget.eventId}')),
      body: BlocBuilder<TicketBloc, TicketState>(
        builder: (context, state) {
          if (state is TicketLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TicketLoadSuccess) {
            final tickets = state.ticket;
            if (tickets.isEmpty) {
              return const Center(child: Text('No tickets available.'));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
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
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => BookingEventPage(
                                user: widget.user,
                                event: widget.event,
                              ),
                        ),
                      );
                    },
                    child: const Text('Pesan Tiket'),
                  ),
                ),
              ],
            );
          } else if (state is TicketFailure) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
