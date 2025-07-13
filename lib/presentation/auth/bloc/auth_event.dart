part of 'auth_bloc.dart';

sealed class AuthEvent {}

class LoginRequested extends AuthEvent {
  final LoginRequestModel requestModel;

  LoginRequested({ required this.requestModel });
}

// Tambahkan event untuk register
class RegisterRequested extends AuthEvent {
  final RegisterRequestModel requestModel;

  RegisterRequested({ required this.requestModel });
}

class LogoutRequested extends AuthEvent {} 