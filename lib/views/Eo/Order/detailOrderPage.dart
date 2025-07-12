// lib/views/Eo/Order/detailOrderPage.dart

import 'package:event_ease/data/model/response/eo/orders/getAllOrdersResponse.dart'; // <-- import Order
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailOrderPage extends StatelessWidget {
  final Order order; // <-- ganti Data jadi Order
  const DetailOrderPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat('dd MMM yyyy, HH:mm');
    final tanggal =
        order.tanggalPemesanan != null
            ? dateFmt.format(order.tanggalPemesanan!) 
            : '-';

    return Scaffold(
      appBar: AppBar(title: Text('Detail Order #${order.id}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow('ID Order', '${order.id}'),
            _buildRow('User ID', '${order.userId}'),
            _buildRow('Kategori Tiket', '${order.tiketKategoriId}'),
            _buildRow('Jumlah Tiket', '${order.jumlahTiket}'),
            _buildRow('Total Harga', 'Rp ${order.totalHarga}'),
            _buildRow('Tanggal Pemesanan', tanggal),
            _buildRow('Status', '${order.status}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
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
