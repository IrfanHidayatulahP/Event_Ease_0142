part of 'profile_bloc.dart';

sealed class ProfileEvent {}

final class FetchProfileRequested extends ProfileEvent {}

final class UpdateProfileRequested extends ProfileEvent {
  final String username;
  final String email;
  final String photoPath; // opsional
  final File? photoFile;

  UpdateProfileRequested({
    required this.username,
    required this.email,
    this.photoPath = '',
    this.photoFile,
  });
}
