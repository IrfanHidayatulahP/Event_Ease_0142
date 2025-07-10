part of 'profile_bloc.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoadSuccess extends ProfileState {
  final String username;
  final String email;
  final String photoPath;

  ProfileLoadSuccess({
    required this.username,
    required this.email,
    required this.photoPath,
  });
}

final class ProfileUpdateSuccess extends ProfileState {
  final String username;
  final String email;
  final String photoPath;

  ProfileUpdateSuccess({
    required this.username,
    required this.email,
    required this.photoPath,
  });
}

final class ProfileFailure extends ProfileState {
  final String error;

  ProfileFailure(this.error);
}