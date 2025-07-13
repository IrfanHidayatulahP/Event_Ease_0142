import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:event_ease/data/model/auth/loginResponse.dart';
import 'package:event_ease/presentation/auth/bloc/auth_bloc.dart';
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
    BodyDashboard(user: widget.user),
    EventPage(user: widget.user),
    OrderPage(user: widget.user),
    ProfilePage(user: widget.user),
  ];

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
        appBar: CustomAppBar(user: widget.user),
        body: IndexedStack(index: _selectedIndex, children: _pages),
        bottomNavigationBar: CustomBottomNavBar(
          user: widget.user,
          selectedIndex: _selectedIndex,
          onItemSelected: (idx) => setState(() => _selectedIndex = idx),
        ),
      ),
    );
  }
}
