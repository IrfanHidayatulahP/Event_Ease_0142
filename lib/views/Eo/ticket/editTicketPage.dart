import 'package:event_ease/data/model/response/eo/tickets/getTicketByEventResponse.dart';
import 'package:event_ease/presentation/ticket/bloc/ticket_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditTicketPage extends StatefulWidget {
  final Datum ticket;
  const EditTicketPage({super.key, required this.ticket});

  @override
  State<EditTicketPage> createState() => _EditTicketPageState();
}

class _EditTicketPageState extends State<EditTicketPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaC;
  late TextEditingController _hargaC;
  late TextEditingController _totC;
  late TextEditingController _terC;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _namaC = TextEditingController(text: widget.ticket.nama);
    _hargaC = TextEditingController(text: widget.ticket.harga?.toString());
    _totC = TextEditingController(text: widget.ticket.kuotaTotal?.toString());
    _terC = TextEditingController(
      text: widget.ticket.kuotaTersedia?.toString(),
    );
  }

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;
    final total = int.parse(_totC.text.trim());
    final ter = int.parse(_terC.text.trim());
    if (ter > total) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kuota tersedia tidak boleh > total kuota'),
        ),
      );
      return;
    }

    setState(() => _busy = true);
    context.read<TicketBloc>().add(
      UpdateTicketRequested(
        widget.ticket.eventId!,
        _namaC.text.trim(),
        double.parse(_hargaC.text.trim()),
        total,
        ter,
        ticketId: widget.ticket.id!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TicketBloc, TicketState>(
      listener: (_, state) {
        if (state is TicketUpdateSuccess) {
          Navigator.pop(context, state.editTicket); // kembali ke TicketPage
        } else if (state is TicketFailure) {
          setState(() => _busy = false);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit Ticket')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _field(_namaC, 'Nama Tiket'),
                const SizedBox(height: 16),
                _field(_hargaC, 'Harga', number: true),
                const SizedBox(height: 16),
                _field(_totC, 'Kuota Total', integer: true),
                const SizedBox(height: 16),
                _field(_terC, 'Kuota Tersedia', integer: true),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _busy ? null : _onSave,
                  child:
                      _busy
                          ? const CircularProgressIndicator()
                          : const Text('Simpan Perubahan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController c,
    String label, {
    bool number = false,
    bool integer = false,
  }) {
    return TextFormField(
      controller: c,
      keyboardType:
          number
              ? const TextInputType.numberWithOptions(decimal: true)
              : integer
              ? TextInputType.number
              : TextInputType.text,
      decoration: InputDecoration(labelText: label),
      validator: (v) {
        if (v == null || v.isEmpty) return 'Required';
        if (number && double.tryParse(v) == null) return 'Enter valid number';
        if (integer && int.tryParse(v) == null) return 'Enter valid integer';
        return null;
      },
    );
  }
}
