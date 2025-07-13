import 'package:event_ease/data/model/auth/loginResponse.dart';
import 'package:flutter/material.dart';

class UserNavBar extends StatelessWidget {
  final Data user;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const UserNavBar({
    super.key,
    required this.user,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  static const _labels = ['Dashboard', 'Event', 'Riwayat', 'Profile'];
  static const _icons = [
    Icons.dashboard_rounded,
    Icons.event_rounded,
    Icons.history_rounded,
    Icons.person_outline_rounded
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_icons.length, (i) {
          final selected = i == selectedIndex;
          return GestureDetector(
            onTap: () => onItemSelected(i),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: selected ? 48 : 40,
                  height: selected ? 48 : 40,
                  decoration: BoxDecoration(
                    color: selected ? Colors.deepOrange : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _icons[i],
                    color: selected ? Colors.white : Colors.white70,
                    size: selected ? 28 : 24,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _labels[i],
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.white70,
                    fontSize: 12,
                    fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
