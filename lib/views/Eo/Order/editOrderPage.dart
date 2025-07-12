// lib/views/Eo/Order/editOrderPage.dart

import 'package:event_ease/data/model/response/eo/orders/getAllOrdersResponse.dart'; // <-- import Order
import 'package:event_ease/presentation/order/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditOrderPage extends StatefulWidget {
  final Order order; // <-- ganti Data jadi Order
  const EditOrderPage({super.key, required this.order});

  @override
  State<EditOrderPage> createState() => _EditOrderPageState();
}

class _EditOrderPageState extends State<EditOrderPage> {
  late TextEditingController _statusController;
  late TextEditingController _jumlahTiketController;
  late TextEditingController _totalHargaController;
  late TextEditingController _tanggalPesanController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan nilai dari widget.order
    _statusController = TextEditingController(text: widget.order.status);
    _jumlahTiketController = TextEditingController(
      text: widget.order.jumlahTiket.toString(),
    );
    _totalHargaController = TextEditingController(
      text: widget.order.totalHarga.toString(),
    );

    final DateTime tanggal = widget.order.tanggalPemesanan!;
    _tanggalPesanController = TextEditingController(
      text: tanggal.toIso8601String(),
    );
  }

  @override
  void dispose() {
    _statusController.dispose();
    _jumlahTiketController.dispose();
    _totalHargaController.dispose();
    _tanggalPesanController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    setState(() => _isSaving = true);
    final bloc = context.read<OrderBloc>();

    // Positional args sesuai event signature
    final int? userId = widget.order.userId;
    final int? tiketKategoriId = widget.order.tiketKategoriId;
    final String status = _statusController.text;
    final int jumlahTiket = int.parse(_jumlahTiketController.text);
    final double totalHarga = double.parse(_totalHargaController.text);
    final DateTime tanggalPemesanan = DateTime.parse(
      _tanggalPesanController.text,
    );

    bloc.add(
      UpdateOrderRequested(
        userId!,
        tiketKategoriId!,
        status,
        jumlahTiket,
        totalHarga,
        tanggalPemesanan, 
        orderId: widget.order.id!.toInt(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Order')),
      body: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderFailure) {
            setState(() => _isSaving = false);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.error}')));
          } else if (state is OrderUpdateSuccess) {
            setState(() => _isSaving = false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Order updated successfully')),
            );
            Navigator.pop(context, state.editOrder);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _statusController,
                decoration: const InputDecoration(labelText: 'Status Order'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _jumlahTiketController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Jumlah Tiket'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _totalHargaController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: 'Total Harga'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _tanggalPesanController,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Pemesanan',
                  hintText: 'YYYY-MM-DDTHH:MM:SS',
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _saveChanges,
                  child:
                      _isSaving
                          ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
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
