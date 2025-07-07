// lib/views/eo/widgets/custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:event_ease/data/model/auth/loginResponse.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Data user;
  const CustomAppBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: const [
                      Text(
                        'Good Morning ',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      Text('😊', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  Text(
                    user.username ?? '-',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.black,
                    size: 28,
                  ),
                  onPressed: () {},
                ),
                const Positioned(
                  right: 10,
                  top: 12,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox(width: 8, height: 8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}
