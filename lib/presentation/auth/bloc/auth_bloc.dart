import 'package:bloc/bloc.dart';
import 'package:event_ease/data/model/auth/loginRequest.dart';
import 'package:event_ease/data/model/auth/loginResponse.dart';
import 'package:event_ease/data/model/auth/registerRequest.dart';
import 'package:event_ease/data/repository/authRepository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await authRepository.login(event.requestModel);

    result.fold(
      (l) => emit(AuthFailure(error: l)),
      (r) => emit(AuthSuccess(responseModel: r)),
    );
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await authRepository.register(event.requestModel);

    result.fold(
      (l) => emit(RegisterFailure(error: l)),
      (r) => emit(RegisterSuccess(message: r)),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authRepository.logout();
      emit(LogoutSuccess(message: 'Berhasil logout'));
    } catch (e) {
      emit(AuthFailure(error: 'Gagal logout: $e'));
    }
  }
}
