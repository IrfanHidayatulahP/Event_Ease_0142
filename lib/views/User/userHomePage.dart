import 'package:event_ease/data/model/auth/loginResponse.dart';
import 'package:event_ease/presentation/auth/bloc/auth_bloc.dart';
import 'package:event_ease/presentation/events/bloc/event_bloc.dart';
import 'package:event_ease/views/Eo/Order/orderByUserPage.dart';
import 'package:event_ease/views/Eo/components/CustomAppBar.dart';
import 'package:event_ease/views/User/components/userNavBar.dart';
import 'package:event_ease/views/Eo/profile/profilePage.dart';
import 'package:event_ease/views/User/events/userEventPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserHomePage extends StatefulWidget {
  final Data user;
  const UserHomePage({super.key, required this.user});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    context.read<EventBloc>().add(FetchEventsRequested());

    // Inisialisasi semua halaman
    _pages = [
      _buildDashboardView(),
      UserEventPage(user: widget.user),
      OrderByUserPage(user: widget.user),
      ProfilePage(user: widget.user),
    ];
  }

  Widget _buildDashboardView() {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        if (state is EventLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is EventLoadSuccess) {
          final events = state.events;

          if (events.isEmpty) {
            return const Center(child: Text('Belum ada event tersedia.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: events.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final event = events[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(event.nama ?? 'No Title'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.deskripsi ?? ''),
                      const SizedBox(height: 4),
                      Text(
                        'Tanggal: ${_formatDate(event.startDate)} - ${_formatDate(event.endDate)}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Lokasi: ${event.lokasi ?? '-'}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        } else if (state is EventFailure) {
          return Center(child: Text('Gagal memuat event: ${state.error}'));
        } else {
          return const SizedBox();
        }
      },
    );
  }

  void _handleNavigation(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/login', (route) => false);
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(user: widget.user, isUser: true),
        body: IndexedStack(index: _selectedIndex, children: _pages),
        bottomNavigationBar: UserNavBar(
          selectedIndex: _selectedIndex,
          onItemSelected: _handleNavigation,
          user: widget.user,
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    return '${date.day}/${date.month}/${date.year}';
  }
}
