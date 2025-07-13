part of 'images_bloc.dart';

sealed class ImagesEvent {}

class FetchImages extends ImagesEvent {}

class AddImage extends ImagesEvent {
  final AddImageRequest request;

  AddImage(this.request);

  @override
  List<Object?> get props => [request];
}

class EditImage extends ImagesEvent {
  final String id;
  final EditImageRequestModel request;

  EditImage(this.id, this.request);

  @override
  List<Object?> get props => [id, request];
}