// lib/views/eo/event_page.dart

import 'package:event_ease/data/model/auth/loginResponse.dart';
import 'package:event_ease/presentation/events/bloc/event_bloc.dart';
import 'package:event_ease/views/Eo/components/CustomAppBar.dart';
import 'package:event_ease/views/Eo/components/CustomNavBar.dart';
import 'package:event_ease/views/Eo/event/createEventPage.dart';
import 'package:event_ease/views/Eo/event/eventDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventPage extends StatefulWidget {
  final Data user;

  const EventPage({super.key, required this.user});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  int _selectedIndex = 1; // Event menu aktif

  @override
  void initState() {
    super.initState();
    context.read<EventBloc>().add(FetchEventsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// ← Pass the real user in here:
      appBar: CustomAppBar(user: widget.user),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'My Events',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: IconButton(
                    icon: const Icon(Icons.add_circle_outline, size: 28),
                    onPressed: () {
                      // Navigate to create event page
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CreateEventPage(),
                      ));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<EventBloc, EventState>(
                builder: (context, state) {
                  if (state is EventLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is EventLoadSuccess) {
                    final events = state.events;
                    if (events.isEmpty) {
                      return const Center(child: Text('No events yet'));
                    }
                    return ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (_, index) {
                        final event = events[index];
                        return InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventDetailPage(event: event),
                              ),
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event.nama ?? '-',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    event.deskripsi ?? '-',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.date_range, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        event.startDate != null
                                            ? '${event.startDate!.toLocal()}'
                                                .split(' ')[0]
                                            : '-',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(width: 16),
                                      const Icon(Icons.location_on, size: 16),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          event.lokasi ?? '-',
                                          style: const TextStyle(fontSize: 14),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is EventFailure) {
                    return Center(child: Text(state.error));
                  }
                  return const Center(child: Text('Loading events...'));
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        user: widget.user,
        selectedIndex: _selectedIndex,
        onItemSelected: (idx) {
          setState(() => _selectedIndex = idx);
        },
      ),
    );
  }
}
