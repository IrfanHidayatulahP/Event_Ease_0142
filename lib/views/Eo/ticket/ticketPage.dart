import 'package:event_ease/presentation/ticket/bloc/ticket_bloc.dart';
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
    // Dispatch fetch tickets for this event
    context.read<TicketBloc>().add(FetchTicketRequest(widget.eventId.toString()));
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
            final tickets = state.ticket
                .where((t) => t.eventId == widget.eventId)
                .toList();
            if (tickets.isEmpty) {
              return const Center(child: Text('No tickets available.'));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: tickets.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final t = tickets[index];
                return ListTile(
                  title: Text(t.nama ?? '-'),
                  subtitle: Text(
                    'Price: \$${t.harga}\nQuota: ${t.kuotaTotal}  Available: ${t.kuotaTersedia}',
                  ),
                  isThreeLine: true,
                );
              },
            );
          } else if (state is TicketFailure) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
