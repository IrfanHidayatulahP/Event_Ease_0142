import 'dart:io';
import 'package:event_ease/presentation/profile/bloc/profile_bloc.dart';
import 'package:event_ease/views/cameras/cameraPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  String? _photoPath; // Local photo path (e.g. from camera)
  String? _initialPhotoUrl; // Optional: From backend profile data
  File? _photoFile;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();

    context.read<ProfileBloc>().add(FetchProfileRequested());
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Widget _buildPhotoPreview() {
    if (_photoPath != null) {
      return Image.file(
        File(_photoPath!),
        width: 120,
        height: 120,
        fit: BoxFit.cover,
      );
    } else if (_initialPhotoUrl != null && _initialPhotoUrl!.isNotEmpty) {
      return Image.network(
        _initialPhotoUrl!,
        width: 120,
        height: 120,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      );
    } else {
      return const Icon(Icons.account_circle, size: 120, color: Colors.grey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdateSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Profile updated!')));
            Navigator.pop(context, true);
          } else if (state is ProfileFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to update profile: ${state.error}'),
              ),
            );
          } else if (state is ProfileLoadSuccess) {
            _usernameController.text = state.username;
            _emailController.text = state.email;
            _initialPhotoUrl = state.photoPath;
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Edit Your Profile',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                // FOTO
                Center(child: _buildPhotoPreview()),
                const SizedBox(height: 8),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final file = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CameraPage()),
                      );

                      if (file != null && file is File) {
                        setState(() {
                          _photoPath = file.path;
                          _photoFile = file;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Foto berhasil diambil'),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Ambil Foto'),
                  ),
                ),

                const SizedBox(height: 24),

                // USERNAME
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                const SizedBox(height: 16),

                // EMAIL
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 24),

                // SUBMIT
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      final username = _usernameController.text.trim();
                      final email = _emailController.text.trim();

                      context.read<ProfileBloc>().add(
                        UpdateProfileRequested(
                          username: username,
                          email: email,
                          photoPath: _photoPath ?? '',
                          photoFile: _photoFile,
                        ),
                      );
                    },
                    child: const Text('Save Changes'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
