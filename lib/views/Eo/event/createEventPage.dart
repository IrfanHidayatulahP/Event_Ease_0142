import 'package:event_ease/data/model/request/eo/event/addEventRequest.dart';
import 'package:event_ease/presentation/events/bloc/event_bloc.dart';
import 'package:event_ease/views/maps/mapPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  late TextEditingController _eventNameController;
  late TextEditingController _eventDescriptionController;
  late TextEditingController _eventStartDateController;
  late TextEditingController _eventEndDateController;
  late TextEditingController _eventLocationController;

  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  @override
  void initState() {
    super.initState();
    _eventNameController = TextEditingController();
    _eventDescriptionController = TextEditingController();
    _eventStartDateController = TextEditingController();
    _eventEndDateController = TextEditingController();
    _eventLocationController = TextEditingController();
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventDescriptionController.dispose();
    _eventStartDateController.dispose();
    _eventEndDateController.dispose();
    _eventLocationController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(
    BuildContext context,
    TextEditingController controller,
    bool isStart,
  ) async {
    final initialDate = DateTime.now();
    final firstDate = DateTime(2000);
    final lastDate = DateTime(2100);
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null) {
      controller.text =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      if (isStart) {
        _selectedStartDate = picked;
      } else {
        _selectedEndDate = picked;
      }
    }
  }

  void _submit() {
    final name = _eventNameController.text.trim();
    final desc = _eventDescriptionController.text.trim();
    final loc = _eventLocationController.text.trim();

    if (name.isEmpty ||
        desc.isEmpty ||
        loc.isEmpty ||
        _selectedStartDate == null ||
        _selectedEndDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields and select dates'),
        ),
      );
      return;
    }

    context.read<EventBloc>().add(
      AddEventRequested(
        request: AddEventRequest(
          nama: name,
          deskripsi: desc,
          startDate: _selectedStartDate,
          endDate: _selectedEndDate,
          lokasi: loc,
        ),
      ),
    );
  }

  Future<void> _navigateToMapPage() async {
    final pickedAddress = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MapPage()),
    );

    if (pickedAddress != null && pickedAddress is String) {
      setState(() {
        _eventLocationController.text = pickedAddress;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EventBloc, EventState>(
      listener: (context, state) {
        if (state is EventAddSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Event created successfully!')),
          );
          _eventNameController.clear();
          _eventDescriptionController.clear();
          _eventStartDateController.clear();
          _eventEndDateController.clear();
          _eventLocationController.clear();
          _selectedStartDate = null;
          _selectedEndDate = null;
          Navigator.pop(context);
        } else if (state is EventFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Failed: ${state.error}')));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Create Event')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _eventNameController,
                  decoration: const InputDecoration(labelText: 'Event Name'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _eventDescriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _eventStartDateController,
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'Start Date'),
                  onTap:
                      () => _pickDate(context, _eventStartDateController, true),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _eventEndDateController,
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'End Date'),
                  onTap:
                      () => _pickDate(context, _eventEndDateController, false),
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
                const SizedBox(height: 8),
                TextField(
                  controller: _eventLocationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                ),
                const SizedBox(height: 16),
                BlocBuilder<EventBloc, EventState>(
                  builder: (context, state) {
                    if (state is EventLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submit,
                        child: const Text('Tambah Event'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
