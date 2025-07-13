import 'package:bloc/bloc.dart';
import 'package:event_ease/data/model/request/eo/event/addEventRequest.dart';
import 'package:event_ease/data/model/request/eo/images/addImageRequest.dart';
import 'package:event_ease/data/model/request/eo/images/editImageRequest.dart';
import 'package:event_ease/data/model/response/eo/images/addImageResponse.dart';
import 'package:event_ease/data/model/response/eo/images/editImageResponse.dart';
import 'package:event_ease/data/model/response/eo/images/getImageByEventResponse.dart';
import 'package:event_ease/data/repository/imageRepository.dart';

part 'images_event.dart';
part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final ImageRepository repository;

  ImagesBloc(this.repository) : super(ImagesInitial()) {
    on<FetchImages>(_onFetchImages);
    on<AddImage>(_onAddImage);
    on<EditImage>(_onEditImage);
  }

  Future<void> _onFetchImages(FetchImages event, Emitter<ImagesState> emit) async {
    emit(ImageLoading());
    final result = await repository.fetchImage();
    result.fold(
      (error) => emit(ImageError(error)),
      (data) => emit(ImageLoaded(data)),
    );
  }

  Future<void> _onAddImage(AddImage event, Emitter<ImagesState> emit) async {
    emit(ImageLoading());
    final result = await repository.addImage(event.request as AddEventRequest);
    result.fold(
      (error) => emit(ImageError(error)),
      (data) => emit(ImageAdded(data)),
    );
  }

  Future<void> _onEditImage(EditImage event, Emitter<ImagesState> emit) async {
    emit(ImageLoading());
    final result = await repository.updateImage(event.id, event.request);
    result.fold(
      (error) => emit(ImageError(error)),
      (data) => emit(ImageEdited(data)),
    );
  }
}
