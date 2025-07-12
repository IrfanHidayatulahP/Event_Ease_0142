import 'package:event_ease/data/model/request/eo/tickets/addTicketByEventRequest.dart';
import 'package:event_ease/presentation/ticket/bloc/ticket_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTicketPage extends StatefulWidget {
  final int eventId;
  const AddTicketPage({super.key, required this.eventId});

  @override
  State<AddTicketPage> createState() => _AddTicketPageState();
}

class _AddTicketPageState extends State<AddTicketPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaC = TextEditingController();
  final _hargaC = TextEditingController();
  final _totC = TextEditingController();
  final _terC = TextEditingController();
  bool _busy = false;

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

    final req = AddTicketByEventRequestModel(
      eventId: widget.eventId,
      nama: _namaC.text.trim(),
      harga: _hargaC.text.trim(),
      kuotaTotal: total,
      kuotaTersedia: ter,
    );

    context.read<TicketBloc>().add(AddTicketRequested(req));
  }

  @override
  Widget build(BuildContext c) {
    return BlocListener<TicketBloc, TicketState>(
      listener: (_, state) {
        if (state is TicketAddSuccess) {
          debugPrint("=== TicketAddSuccess: ${state.newTicket.nama}");
          Navigator.pop(
            c,
            state.newTicket,
          ); // Kembali ke TicketPage dengan data
        }
        if (state is TicketFailure) {
          setState(() => _busy = false);
          ScaffoldMessenger.of(
            c,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Ticket')),
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
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child:
                      _busy
                          ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                          : const Text('Simpan Tiket'),
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
