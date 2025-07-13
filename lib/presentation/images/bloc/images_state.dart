part of 'images_bloc.dart';

sealed class ImagesState {}

final class ImagesInitial extends ImagesState {}

class ImageLoading extends ImagesState {}

class ImageLoaded extends ImagesState {
  final GetImageByEventResponseModel images;

  ImageLoaded(this.images);

  @override
  List<Object?> get props => [images];
}

class ImageAdded extends ImagesState {
  final AddImageResponseModel response;

  ImageAdded(this.response);

  @override
  List<Object?> get props => [response];
}

class ImageEdited extends ImagesState {
  final EditImageResponseModel response;

  ImageEdited(this.response);

  @override
  List<Object?> get props => [response];
}

class ImageError extends ImagesState {
  final String message;

  ImageError(this.message);

  @override
  List<Object?> get props => [message];
}