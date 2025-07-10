import 'package:event_ease/data/model/auth/loginResponse.dart';
import 'package:event_ease/presentation/profile/bloc/profile_bloc.dart';
import 'package:event_ease/views/Eo/components/CustomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  final Data user;
  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 3; // Profile menu aktif

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(FetchProfileRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit profile page
              Navigator.pushNamed(context, '/editProfile');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProfileLoadSuccess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            state.photoPath.isNotEmpty
                                ? state.photoPath
                                : 'https://via.placeholder.com/150',
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text('Username: ${state.username}'),
                        Text('Email: ${state.email}'),
                      ],
                    );
                  } else if (state is ProfileFailure) {
                    return Center(child: Text('Error: ${state.error}'));
                  }
                  return const Center(child: Text('No profile data'));
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        user: widget.user, // ← pass the user here
        selectedIndex: _selectedIndex,
        onItemSelected: (idx) {
          setState(() => _selectedIndex = idx);
        },
      ),
    );
  }
}
