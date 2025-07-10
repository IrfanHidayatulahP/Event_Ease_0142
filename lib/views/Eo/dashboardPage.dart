// lib/views/eo/event_page.dart
import 'package:event_ease/views/Eo/components/BodyDashboard.dart';
import 'package:event_ease/views/Eo/components/CustomAppBar.dart';
import 'package:event_ease/views/Eo/components/CustomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:event_ease/presentation/events/bloc/event_bloc.dart';
import 'package:event_ease/data/model/auth/loginResponse.dart';

class DashboardPage extends StatefulWidget {
  final Data user;
  const DashboardPage({super.key, required this.user});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<EventBloc>().add(FetchEventsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(user: widget.user),
      body: const BodyDashboard(),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (idx) => setState(() => _selectedIndex = idx), 
        user: widget.user,
      ),
    );
  }
}
