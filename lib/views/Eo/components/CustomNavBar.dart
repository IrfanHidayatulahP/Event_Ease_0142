// lib/views/eo/widgets/custom_bottom_navbar.dart
import 'package:event_ease/views/Eo/Order/orderPage.dart';
import 'package:event_ease/views/Eo/profile/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:event_ease/views/Eo/event/eventPage.dart';
import 'package:event_ease/views/Eo/dashboardPage.dart'; // Pastikan import ini sesuai path kamu
import 'package:event_ease/data/model/auth/loginResponse.dart';

class CustomBottomNavBar extends StatelessWidget {
  final Data user;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              onItemSelected(0);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => DashboardPage(user: user)),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: selectedIndex == 0 ? 48 : 40,
                  height: selectedIndex == 0 ? 48 : 40,
                  decoration: BoxDecoration(
                    color:
                        selectedIndex == 0
                            ? Colors.deepOrange
                            : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.dashboard_rounded,
                    color: selectedIndex == 0 ? Colors.white : Colors.white70,
                    size: selectedIndex == 0 ? 28 : 24,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Dashboard',
                  style: TextStyle(
                    color: selectedIndex == 0 ? Colors.white : Colors.white70,
                    fontSize: 12,
                    fontWeight:
                        selectedIndex == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              onItemSelected(1);
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => EventPage(user: user)));
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: selectedIndex == 1 ? 48 : 40,
                  height: selectedIndex == 1 ? 48 : 40,
                  decoration: BoxDecoration(
                    color:
                        selectedIndex == 1
                            ? Colors.deepOrange
                            : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.event_rounded,
                    color: selectedIndex == 1 ? Colors.white : Colors.white70,
                    size: selectedIndex == 1 ? 28 : 24,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Event',
                  style: TextStyle(
                    color: selectedIndex == 1 ? Colors.white : Colors.white70,
                    fontSize: 12,
                    fontWeight:
                        selectedIndex == 1
                            ? FontWeight.bold
                            : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              onItemSelected(2);
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => OrderPage(user: user)));
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: selectedIndex == 2 ? 48 : 40,
                  height: selectedIndex == 2 ? 48 : 40,
                  decoration: BoxDecoration(
                    color:
                        selectedIndex == 2
                            ? Colors.deepOrange
                            : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.history_rounded,
                    color: selectedIndex == 2 ? Colors.white : Colors.white70,
                    size: selectedIndex == 2 ? 28 : 24,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Riwayat Order',
                  style: TextStyle(
                    color: selectedIndex == 2 ? Colors.white : Colors.white70,
                    fontSize: 12,
                    fontWeight:
                        selectedIndex == 2
                            ? FontWeight.bold
                            : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              onItemSelected(3);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ProfilePage(user: user)),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: selectedIndex == 3 ? 48 : 40,
                  height: selectedIndex == 3 ? 48 : 40,
                  decoration: BoxDecoration(
                    color:
                        selectedIndex == 3
                            ? Colors.deepOrange
                            : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_outline_rounded,
                    color: selectedIndex == 3 ? Colors.white : Colors.white70,
                    size: selectedIndex == 3 ? 28 : 24,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Profile',
                  style: TextStyle(
                    color: selectedIndex == 3 ? Colors.white : Colors.white70,
                    fontSize: 12,
                    fontWeight:
                        selectedIndex == 3
                            ? FontWeight.bold
                            : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
