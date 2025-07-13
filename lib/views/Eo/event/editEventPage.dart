import 'package:event_ease/views/maps/mapPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:event_ease/data/model/response/eo/event/getEventResponse.dart';
import 'package:event_ease/presentation/events/bloc/event_bloc.dart';

class EditEventPage extends StatefulWidget {
  final Datum event;
  const EditEventPage({Key? key, required this.event}) : super(key: key);

  @override
  State<EditEventPage> createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _locationController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.event.nama);
    _descController = TextEditingController(text: widget.event.deskripsi);
    _locationController = TextEditingController(text: widget.event.lokasi);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _navigateToMapPage() async {
    final pickedAddress = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MapPage()),
    );

    if (pickedAddress != null && pickedAddress is String) {
      setState(() {
        _locationController.text = pickedAddress;
      });
    }
  }

  void _saveChanges() {
    setState(() => _isSaving = true);
    final bloc = context.read<EventBloc>();
    final id = widget.event.id?.toString() ?? '';

    bloc.add(
      UpdateEventRequested(
        _nameController.text,
        _descController.text,
        widget.event.startDate is String
            ? DateTime.parse(widget.event.startDate as String)
            : widget.event.startDate as DateTime,
        widget.event.endDate is String
            ? DateTime.parse(widget.event.endDate as String)
            : widget.event.endDate as DateTime,
        _locationController.text,
        eventId: id, // <<< pastikan ini terisi
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Event')),
      body: BlocListener<EventBloc, EventState>(
        listener: (context, state) {
          if (state is EventFailure) {
            setState(() => _isSaving = false);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.error}')));
          } else if (state is EventUpdateSuccess) {
            setState(() => _isSaving = false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Event updated successfully!')),
            );
            Navigator.pop(context, state.editEvent);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Event Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _navigateToMapPage,
                  icon: const Icon(Icons.map),
                  label: const Text("Pilih Lokasi di Map"),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _saveChanges,
                  child:
                      _isSaving
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
