import 'package:bloc/bloc.dart';
import 'package:event_ease/data/model/response/eo/profile/editProfileResponse.dart';
import 'package:event_ease/data/repository/profileRepository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repo;

  ProfileBloc(this.repo) : super(ProfileInitial()) {
    on<FetchProfileRequested>(_onFetch);
    on<UpdateProfileRequested>(_onUpdate);
  }

  Future<void> _onFetch(
    FetchProfileRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final result = await repo.fetchProfile();
    result.fold(
      (l) => emit(ProfileFailure(l)),
      (r) => emit(
        ProfileLoadSuccess(
          username: r.data?.username ?? '',
          email: r.data?.email ?? '',
          photoPath: r.data?.photoPath ?? '',
        ),
      ),
    );
  }

  Future<void> _onUpdate(
    UpdateProfileRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final result = await repo.updateProfile(
      EditProfileResponseModel(
        data:
            event.username.isNotEmpty ||
                    event.email.isNotEmpty ||
                    event.photoPath.isNotEmpty
                ? Data(
                  username: event.username,
                  email: event.email,
                  photoPath: event.photoPath,
                )
                : null,
        status: 'success',
      ),
    );
    result.fold(
      (l) => emit(ProfileFailure(l)),
      (r) => emit(
        ProfileUpdateSuccess(
          username: r.data?.username ?? '',
          email: r.data?.email ?? '',
          photoPath: r.data?.photoPath ?? '',
        ),
      ),
    );
  }
}
