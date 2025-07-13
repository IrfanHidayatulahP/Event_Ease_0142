import 'package:event_ease/data/model/auth/loginResponse.dart';
import 'package:event_ease/data/model/request/eo/orders/addOrderRequest.dart';
import 'package:event_ease/data/model/response/eo/event/getEventResponse.dart'
    as event_model;
import 'package:event_ease/data/model/response/eo/tickets/getTicketByEventResponse.dart'
    as ticket_model;
import 'package:event_ease/presentation/order/bloc/order_bloc.dart';
import 'package:event_ease/presentation/ticket/bloc/ticket_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingEventPage extends StatefulWidget {
  final Data user;
  final event_model.Datum event;

  const BookingEventPage({super.key, required this.user, required this.event});

  @override
  State<BookingEventPage> createState() => _BookingEventPageState();
}

class _BookingEventPageState extends State<BookingEventPage> {
  final TextEditingController _jumlahTiketController =
      TextEditingController(); // default kosong
  ticket_model.Datum? _selectedTicket;

  /// Jumlah tiket yang diinput user
  int? get jumlahTiket {
    final val = int.tryParse(_jumlahTiketController.text.trim());
    return (val != null && val > 0) ? val : null;
  }

  /// Harga satuan berdasarkan tiket yang dipilih (meng-handle DECIMAL(12,2))
  int get hargaSatuan {
    final raw = _selectedTicket?.harga ?? '0';
    // Hapus koma ribuan
    final normalized = raw.replaceAll(',', '');
    // Parse ke double, lalu ke int
    final asDouble = double.tryParse(normalized) ?? 0.0;
    return asDouble.toInt();
  }

  /// Total harga = harga satuan × jumlah tiket
  int? get totalHarga {
    final j = jumlahTiket;
    return (j != null && _selectedTicket != null) ? hargaSatuan * j : null;
  }

  @override
  void initState() {
    super.initState();
    // Fetch tiket untuk event ini
    context.read<TicketBloc>().add(
      FetchTicketRequest(widget.event.id!.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pesan Tiket – ${widget.event.nama}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<OrderBloc, OrderState>(
          listener: (ctx, orderState) {
            if (orderState is OrderFailure) {
              ScaffoldMessenger.of(ctx).showSnackBar(
                SnackBar(
                  content: Text('Gagal memesan tiket: ${orderState.error}'),
                ),
              );
            } else if (orderState is OrderLoadByUserSuccess) {
              ScaffoldMessenger.of(ctx).showSnackBar(
                const SnackBar(content: Text('Tiket berhasil dipesan')),
              );
              Navigator.pop(ctx);
            }
          },
          builder: (ctx, orderState) {
            return BlocBuilder<TicketBloc, TicketState>(
              builder: (ctx2, ticketState) {
                if (ticketState is TicketLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (ticketState is TicketFailure) {
                  return Center(child: Text('Error: ${ticketState.error}'));
                }
                if (ticketState is TicketLoadSuccess) {
                  final tickets = ticketState.ticket;

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nama: ${widget.user.username}'),
                        Text('Email: ${widget.user.email}'),
                        const SizedBox(height: 16),

                        // Dropdown kategori tiket
                        DropdownButtonFormField<ticket_model.Datum>(
                          value: _selectedTicket,
                          hint: const Text('Pilih Kategori Tiket'),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          items:
                              tickets.map((t) {
                                return DropdownMenuItem<ticket_model.Datum>(
                                  value: t,
                                  child: Text('${t.nama} – Rp${t.harga}'),
                                );
                              }).toList(),
                          onChanged: (newTicket) {
                            setState(() {
                              _selectedTicket = newTicket;
                            });
                          },
                        ),
                        const SizedBox(height: 12),

                        // Input jumlah tiket
                        TextField(
                          controller: _jumlahTiketController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Jumlah Tiket',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (_) {
                            setState(() {}); // trigger rebuild untuk totalHarga
                          },
                        ),
                        const SizedBox(height: 12),

                        // Tampilkan harga satuan & total jika valid
                        if (_selectedTicket != null) ...[
                          Text('Harga Satuan: Rp$hargaSatuan'),
                          const SizedBox(height: 8),
                          if (totalHarga != null)
                            Text(
                              'Total Harga: Rp$totalHarga',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          const SizedBox(height: 24),
                        ],

                        // Tombol Kirim Pemesanan
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_selectedTicket == null ||
                                  jumlahTiket == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Mohon pilih kategori dan jumlah tiket valid',
                                    ),
                                  ),
                                );
                                return;
                              }

                              final request = AddOrderRequestModel(
                                userId: widget.user.id,
                                tiketKategoriId: _selectedTicket!.id,
                                status: 'pending',
                                jumlahTiket: jumlahTiket!,
                                totalHarga: totalHarga.toString(),
                                tanggalPemesanan: DateTime.now(),
                              );
                              context.read<OrderBloc>().add(
                                AddOrderRequested(request: request),
                              );
                            },
                            child: const Text('Kirim Pemesanan'),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _jumlahTiketController.dispose();
    super.dispose();
  }
}
