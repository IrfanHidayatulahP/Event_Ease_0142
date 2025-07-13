import 'package:event_ease/data/model/auth/loginResponse.dart';
import 'package:event_ease/presentation/events/bloc/event_bloc.dart';
import 'package:event_ease/data/model/response/eo/event/getEventResponse.dart';
import 'package:event_ease/views/User/events/eventTicketPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserEventPage extends StatefulWidget {
  final Data user;

  const UserEventPage({super.key, required this.user});

  @override
  State<UserEventPage> createState() => _UserEventPageState();
}

class _UserEventPageState extends State<UserEventPage> {
  List<Datum> _allEvents = [];
  List<Datum> _filteredEvents = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<EventBloc>().add(FetchEventsRequested());
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredEvents =
          _allEvents
              .where((e) => (e.nama ?? '').toLowerCase().contains(query))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Event')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Cari nama event...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<EventBloc, EventState>(
                builder: (context, state) {
                  if (state is EventLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is EventLoadSuccess) {
                    _allEvents = state.events;
                    _filteredEvents =
                        _searchController.text.isEmpty
                            ? _allEvents
                            : _filteredEvents;

                    if (_filteredEvents.isEmpty) {
                      return const Center(
                        child: Text('Tidak ada event ditemukan.'),
                      );
                    }

                    return ListView.separated(
                      itemCount: _filteredEvents.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final event = _filteredEvents[index];
                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text(event.nama ?? '-'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(event.deskripsi ?? '-'),
                                Text('Lokasi: ${event.lokasi ?? '-'}'),
                                Text(
                                  'Tanggal: ${_formatDate(event.startDate)}',
                                ),
                              ],
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => EventTicketPage(
                                          eventId: event.id!,
                                          user: widget.user,
                                          event: event,
                                        ),
                                  ),
                                );
                              },
                              child: const Text('Pesan'),
                            ),
                            isThreeLine: true,
                          ),
                        );
                      },
                    );
                  } else if (state is EventFailure) {
                    return Center(
                      child: Text('Gagal memuat event: ${state.error}'),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
