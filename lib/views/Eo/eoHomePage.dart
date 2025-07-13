// lib/views/Eo/eoHomePage.dart

import 'package:flutter/material.dart';
import 'package:event_ease/data/model/auth/loginResponse.dart';
import 'package:event_ease/views/Eo/components/CustomAppBar.dart';
import 'package:event_ease/views/Eo/components/BodyDashboard.dart';
import 'package:event_ease/views/Eo/components/CustomNavBar.dart';
import 'package:event_ease/views/Eo/event/eventPage.dart';
import 'package:event_ease/views/Eo/Order/orderPage.dart';
import 'package:event_ease/views/Eo/profile/profilePage.dart';

class EoHomePage extends StatefulWidget {
  final Data user;
  const EoHomePage({super.key, required this.user});

  @override
  State<EoHomePage> createState() => _EoHomePageState();
}

class _EoHomePageState extends State<EoHomePage> {
  int _selectedIndex = 0;

  /// Daftar konten untuk tiap tab
  late final List<Widget> _pages = [
    // Tab “Dashboard” sekarang langsung pakai BodyDashboard
    BodyDashboard(user: widget.user),
    // Tab “Event”
    EventPage(user: widget.user),
    // Tab “Riwayat Order”
    OrderPage(user: widget.user),
    // Tab “Profile”
    ProfilePage(user: widget.user),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar terpusat di parent
      appBar: CustomAppBar(user: widget.user),
      // Tampilan halaman sesuai index
      body: IndexedStack(index: _selectedIndex, children: _pages),
      // BottomNavBar terpusat di parent
      bottomNavigationBar: CustomBottomNavBar(
        user: widget.user,
        selectedIndex: _selectedIndex,
        onItemSelected: (idx) => setState(() => _selectedIndex = idx),
      ),
    );
  }
}
