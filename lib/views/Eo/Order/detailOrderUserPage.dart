import 'package:event_ease/data/model/response/eo/orders/getOrderByUserIdResponse.dart';
import 'package:event_ease/presentation/order/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DetailOrderUserPage extends StatelessWidget {
  final History order;
  const DetailOrderUserPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat('dd MMM yyyy, HH:mm');
    final tanggal =
        order.tanggalPemesanan != null
            ? dateFmt.format(order.tanggalPemesanan!)
            : '-';

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Order #${order.id}'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderUpdateSuccess) {
            // Hanya pop setelah benar-benar sukses
            Navigator.pop(context, true);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Status berhasil diubah menjadi "paid"'),
              ),
            );
          }
          if (state is OrderFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Update failed: ${state.error}')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRow('ID Order', order.id.toString()),
              _buildRow('User ID', order.userId.toString()),
              _buildRow('Kategori Tiket', order.tiketKategoriId.toString()),
              _buildRow('Jumlah Tiket', order.jumlahTiket.toString()),
              _buildRow('Total Harga', 'Rp ${order.totalHarga}'),
              _buildRow('Tanggal Pemesanan', tanggal),
              _buildRow('Status', order.status ?? '-'),
              const SizedBox(height: 24),

              if (order.status != 'paid')
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Dispatch event, jangan pop di sini
                      context.read<OrderBloc>().add(
                        UpdateOrderStatusRequested(
                          orderId: order.id!,
                          newStatus: 'paid',
                        ),
                      );
                    },
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Tandai sebagai Paid'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),

              const SizedBox(height: 16),
              Center(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Kembali'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(flex: 5, child: Text(value)),
        ],
      ),
    );
  }
}
