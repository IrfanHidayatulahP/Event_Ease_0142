// lib/views/eo/event/eventDetailPage.dart
import 'package:event_ease/data/model/response/eo/event/getEventResponse.dart';
import 'package:event_ease/views/Eo/event/editEventPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:event_ease/presentation/events/bloc/event_bloc.dart';

class EventDetailPage extends StatefulWidget {
  final Datum event;
  const EventDetailPage({Key? key, required this.event}) : super(key: key);

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  late Datum _event;
  late String _startDate;
  late String _endDate;

  @override
  void initState() {
    super.initState();
    _event = widget.event;
    _refreshFormattedDates();
  }

  String _formatDate(dynamic raw) {
    if (raw == null) return '-';
    DateTime dt;
    if (raw is DateTime) {
      dt = raw;
    } else if (raw is String) {
      dt = DateTime.parse(raw);
    } else {
      return '-';
    }
    return DateFormat('yyyy-MM-dd').format(dt.toLocal());
  }

  void _refreshFormattedDates() {
    _startDate = _formatDate(_event.startDate);
    _endDate = _formatDate(_event.endDate);
  }

  Future<void> _onRefreshPressed() async {
    final bloc = context.read<EventBloc>();
    bloc.add(FetchEventsRequested());

    await for (final state in bloc.stream) {
      if (state is EventLoadSuccess) {
        // cari ulang event ini di daftar yang baru
        final fresh = state.events.firstWhere(
          (e) => e.id == _event.id,
          orElse: () => _event,
        );
        setState(() {
          _event = fresh;
          _refreshFormattedDates();
        });
        break;
      }
      if (state is EventFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error refreshing: ${state.error}')),
        );
        break;
      }
    }
  }

  Future<void> _onEditPressed() async {
    final result = await Navigator.push<Datum>(
      context,
      MaterialPageRoute(builder: (_) => EditEventPage(event: _event)),
    );
    if (result != null) {
      setState(() {
        _event = result;
        _refreshFormattedDates();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_event.nama ?? 'Event Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _onRefreshPressed,
            tooltip: 'Refresh data',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    _event.nama ?? '-',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  tooltip: 'Edit Event',
                  onPressed: _onEditPressed,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _event.deskripsi ?? 'No description',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18, color: Colors.blue),
                const SizedBox(width: 6),
                Text('Start: $_startDate'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18, color: Colors.red),
                const SizedBox(width: 6),
                Text('End: $_endDate'),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Location: ${_event.lokasi ?? 'No location specified'}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
