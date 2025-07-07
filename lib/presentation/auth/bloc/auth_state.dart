part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final LoginResponseModel responseModel;

  AuthSuccess({ required this.responseModel });
}

final class AuthFailure extends AuthState {
  final String error;

  AuthFailure({ required this.error });
}

// Tambahkan state untuk register
final class RegisterSuccess extends AuthState {
  final String message;

  RegisterSuccess({ required this.message });
}

final class RegisterFailure extends AuthState {
  final String error;

  RegisterFailure({ required this.error });
}