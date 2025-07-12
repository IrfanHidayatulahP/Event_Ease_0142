// lib/views/Eo/Order/detailOrderPage.dart

import 'package:event_ease/data/model/response/eo/orders/getAllOrdersResponse.dart';
import 'package:event_ease/presentation/order/bloc/order_bloc.dart';
import 'package:event_ease/views/Eo/Order/editOrderPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DetailOrderPage extends StatefulWidget {
  final Order initialOrder;
  const DetailOrderPage({super.key, required this.initialOrder, required Order order});

  @override
  State<DetailOrderPage> createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  late Order order;

  @override
  void initState() {
    super.initState();
    order = widget.initialOrder;
  }

  void _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Konfirmasi'),
            content: const Text('Yakin ingin menghapus order ini?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Hapus'),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      context.read<OrderBloc>().add(
        DeleteOrderRequested(orderId: order.id.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat('dd MMM yyyy, HH:mm');
    final tanggal =
        order.tanggalPemesanan != null
            ? dateFmt.format(order.tanggalPemesanan!)
            : '-';

    return Scaffold(
      appBar: AppBar(title: Text('Detail Order #${order.id}')),
      body: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderDeleteSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Order berhasil dihapus')),
            );
            Navigator.pop(context); // kembali ke list page
          } else if (state is OrderFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.error}')));
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
              _buildRow('Status', '${order.status}'),
              const SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Kembali'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final updated = await Navigator.of(context).push<Order>(
                          MaterialPageRoute(
                            builder: (innerCtx) {
                              final bloc = context.read<OrderBloc>();
                              return BlocProvider.value(
                                value: bloc,
                                child: EditOrderPage(order: order),
                              );
                            },
                          ),
                        );
                        if (updated != null) {
                          setState(() => order = updated);
                        }
                      },
                      child: const Text('Edit'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _confirmDelete,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Hapus'),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
