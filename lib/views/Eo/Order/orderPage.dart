import 'package:event_ease/data/model/auth/loginResponse.dart';
import 'package:event_ease/presentation/order/bloc/order_bloc.dart';
import 'package:event_ease/views/Eo/Order/detailOrderPage.dart';
import 'package:event_ease/views/Eo/components/CustomAppBar.dart';
import 'package:event_ease/views/Eo/components/CustomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatefulWidget {
  final Data user;
  const OrderPage({Key? key, required this.user}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final DateFormat _dateFmt = DateFormat('dd MMM yyyy, HH:mm');
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(FetchOrderRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(user: widget.user),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderLoadSuccess) {
            final orders = state.orders;
            if (orders.isEmpty) {
              return const Center(child: Text('No orders available.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (_, idx) {
                final order = orders[idx];
                DateTime? parsedDate;
                if (order.tanggalPemesanan is String) {
                  parsedDate = DateTime.tryParse(order.tanggalPemesanan as String);
                } else if (order.tanggalPemesanan is DateTime) {
                  parsedDate = order.tanggalPemesanan as DateTime;
                }
                final dateText = parsedDate != null ? _dateFmt.format(parsedDate) : '—';

                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailOrderPage(order: order),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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
                          Text('User ID: ${order.userId}'),
                          Text('Category ID: ${order.tiketKategoriId}'),
                          Text('Quantity: ${order.jumlahTiket}'),
                          Text('Date: $dateText'),
                          Text('Status: ${order.status}'),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'Rp ${order.totalHarga}',
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
      bottomNavigationBar: CustomBottomNavBar(
        user: widget.user,
        selectedIndex: _selectedIndex,
        onItemSelected: (idx) => setState(() => _selectedIndex = idx),
      ),
    );
  }
}
