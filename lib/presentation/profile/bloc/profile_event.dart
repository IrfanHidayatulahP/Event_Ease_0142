part of 'profile_bloc.dart';

sealed class ProfileEvent {}

final class FetchProfileRequested extends ProfileEvent {}

final class UpdateProfileRequested extends ProfileEvent {
  final String username;
  final String email;
  final String photoPath;

  UpdateProfileRequested({
    required this.username,
    required this.email,
    required this.photoPath,
  });
}