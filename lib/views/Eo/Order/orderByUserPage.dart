import 'package:event_ease/data/model/auth/loginResponse.dart';
import 'package:event_ease/presentation/order/bloc/order_bloc.dart';
import 'package:event_ease/views/Eo/Order/detailOrderUserPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OrderByUserPage extends StatefulWidget {
  final Data user;

  const OrderByUserPage({super.key, required this.user});

  @override
  State<OrderByUserPage> createState() => _OrderByUserPageState();
}

class _OrderByUserPageState extends State<OrderByUserPage> {
  final DateFormat _dateFmt = DateFormat('dd MMM yyyy, HH:mm');

  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(FetchOrderByUserRequested(widget.user.id!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pesanan Tiket'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderLoadByUserSuccess) {
            final orders = state.hist;
            if (orders.isEmpty) {
              return const Center(
                child: Text('Belum ada riwayat pembelian tiket.'),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (_, idx) {
                final order = orders[idx];
                final parsedDate = order.tanggalPemesanan;
                final dateText =
                    parsedDate != null ? _dateFmt.format(parsedDate) : '—';

                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => DetailOrderUserPage(order: order),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order #${order.id}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Tanggal Pemesanan: $dateText'),
                          Text('Jumlah Tiket: ${order.jumlahTiket}'),
                          Text('Kategori Tiket ID: ${order.tiketKategoriId}'),
                          Text('Status: ${order.status}'),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'Total: Rp ${order.totalHarga}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is OrderFailure) {
            return Center(child: Text('Error: ${state.error}'));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
