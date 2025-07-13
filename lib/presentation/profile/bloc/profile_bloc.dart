import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:event_ease/data/model/request/eo/profile/editProfileRequest.dart';
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
    final requestModel = EditProfileRequestModel(
      username: event.username,
      email: event.email,
      photoPath: event.photoPath,
      photoFile: event.photoFile,
    );

    final result = await repo.updateProfile(requestModel);

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
