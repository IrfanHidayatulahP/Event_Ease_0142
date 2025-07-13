import 'package:event_ease/data/model/response/eo/orders/getOrderByUserIdResponse.dart';
import 'package:flutter/material.dart';
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
      body: Padding(
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
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Kembali'),
              ),
            ),
          ],
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
