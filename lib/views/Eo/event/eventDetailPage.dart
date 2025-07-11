// lib/views/eo/event/eventDetailPage.dart
import 'package:event_ease/data/model/response/eo/event/getEventResponse.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

    // Helper to format either String or DateTime
    String formatDate(dynamic raw) {
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

    _startDate = formatDate(_event.startDate);
    _endDate = formatDate(_event.endDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_event.nama ?? 'Event Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _event.nama ?? '-',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
            Text(
              'Location: ${_event.lokasi ?? 'No location specified'}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
