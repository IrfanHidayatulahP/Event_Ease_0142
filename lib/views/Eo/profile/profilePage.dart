import 'package:event_ease/data/model/auth/loginResponse.dart';
import 'package:event_ease/presentation/profile/bloc/profile_bloc.dart';
import 'package:event_ease/views/Eo/profile/editProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  final Data user;
  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(FetchProfileRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final updated = await Navigator.push<bool>(
                context,
                MaterialPageRoute(builder: (_) => const EditProfilePage()),
              );
              if (updated == true) {
                context.read<ProfileBloc>().add(FetchProfileRequested());
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                        Center(
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                state.photoPath.isNotEmpty
                                    ? NetworkImage(
                                      'https://example.com/uploads/profile/${state.photoPath}',
                                    )
                                    : const NetworkImage(
                                      'https://via.placeholder.com/150',
                                    ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Username: ${state.username}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Email: ${state.email}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    );
                  } else if (state is ProfileFailure) {
                    return Center(child: Text('Error: ${state.error}'));
                  }

                  return const Center(
                    child: Text('No profile data available.'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
