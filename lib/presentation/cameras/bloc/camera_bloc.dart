import 'dart:io';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:event_ease/views/cameras/cameraPage.dart';
import 'package:event_ease/views/cameras/storageHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  late final List<CameraDescription> _cameras;

  CameraBloc() : super(CameraInitial()) {
    on<InitializeCamera>(_onInit);
    on<SwicthCamera>(_onSwitch);
    on<ToggleFlash>(_onToggleFlash);
    on<TakePicture>(_onTakePicture);
    on<TapToFocus>(_onTapToFocus);
    on<PickImageFromGallery>(_onPickGallery);
    on<OpenCameraAndCapture>(_onOpenCamera);
    on<DeleteImage>(_onDeleteImage);
    on<ClearSnackBar>(_onClearSnackBar);
    on<RequestPermission>(_onRequestPermission);
  }

  Future<void> _onInit(
    InitializeCamera event,
    Emitter<CameraState> emit,
  ) async {
    _cameras = await availableCameras();

    await _setupController(0, emit);
  }

  Future<void> _onSwitch(SwicthCamera event, Emitter<CameraState> emit) async {
    if (state is! CameraReady) return;
    final s = state as CameraReady;
    final next = (s.selectedIndex + 1) % _cameras.length;
    await _setupController(next, emit, previous: s);
  }

  Future<void> _onToggleFlash(
    ToggleFlash event,
    Emitter<CameraState> emit,
  ) async {
    if (state is! CameraReady) return;
    final s = state as CameraReady;
    final next =
        s.flashMode == FlashMode.off
            ? FlashMode.auto
            : s.flashMode == FlashMode.auto
            ? FlashMode.always
            : FlashMode.off;
    await s.controller.setFlashMode(next);
    emit(s.copyWith(flashMode: next));
  }

  Future<void> _onTakePicture(
    TakePicture event,
    Emitter<CameraState> emit,
  ) async {
    if (state is! CameraReady) return;
    final s = state as CameraReady;
    final file = await s.controller.takePicture();
    event.onPictureTaken(File(file.path));
  }

  Future<void> _onTapToFocus(
    TapToFocus event,
    Emitter<CameraState> emit,
  ) async {
    if (state is! CameraReady) return;
    final s = state as CameraReady;
    final relative = Offset(
      event.position.dx / event.previewSize.width,
      event.position.dy / event.previewSize.height,
    );
    await s.controller.setFocusPoint(relative);
    await s.controller.setExposurePoint(relative);
  }

  Future<void> _onPickGallery(
    PickImageFromGallery event,
    Emitter<CameraState> emit,
  ) async {
    if (state is! CameraReady) return;
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    final file = File(picked!.path);
    emit(
      (state as CameraReady).copyWith(
        imageFile: file,
        snackBarMessage: 'Berhasil Memilih dari Galeri',
      ),
    );
  }

  Future<void> _onOpenCamera(
    OpenCameraAndCapture event,
    Emitter<CameraState> emit,
  ) async {
    print('[CameraBloc] OpenCameraAndCapture');

    if (state is! CameraReady) {
      print('[CameraBloc] state is not Ready, abort');
      return;
    }

    final file = await Navigator.push<File?>(
      event.context,
      MaterialPageRoute(
        builder:
            (_) => BlocProvider.value(value: this, child: const CameraPage()),
      ),
    );

    if (file != null) {
      final saved = await StorageHelper.saveImage(file, 'camera');
      emit(
        (state as CameraReady).copyWith(
          imageFile: saved,
          snackBarMessage: 'Disimpan di ${saved.path}',
        ),
      );
    }
  }

  Future<void> _onDeleteImage(
    DeleteImage event,
    Emitter<CameraState> emit,
  ) async {
    if (state is! CameraReady) return;
    final s = state as CameraReady;
    await s.imageFile?.delete();
    emit(
      CameraReady(
        controller: s.controller,
        selectedIndex: s.selectedIndex,
        flashMode: s.flashMode,
        imageFile: null,
        snackBarMessage: 'Gambar dihapus',
      ),
    );
  }

  Future<void> _onClearSnackBar(
    ClearSnackBar event,
    Emitter<CameraState> emit,
  ) async {
    if (state is! CameraReady) return;
    final s = state as CameraReady;
    emit(s.copyWith(ClearSnackBar: true));
  }

  Future<void> _setupController(
    int index,
    Emitter<CameraState> emit, {
    CameraReady? previous,
  }) async {
    await previous?.controller.dispose();
    final controller = CameraController(
      _cameras[index],
      ResolutionPreset.max,
      enableAudio: false,
    );
    await controller.initialize();
    await controller.setFlashMode(previous?.flashMode ?? FlashMode.off);

    emit(
      CameraReady(
        controller: controller,
        selectedIndex: index,
        flashMode: previous?.flashMode ?? FlashMode.off,
        imageFile: previous?.imageFile,
        snackBarMessage: null,
      ),
    );
  }

  @override
  Future<void> close() async {
    if (state is CameraReady) {
      final s = state as CameraReady;
      await s.controller.dispose();
    }
    return super.close();
  }

  Future<void> _onRequestPermission(
    RequestPermission event,
    Emitter<CameraState> emit,
  ) async {
    final statuses =
        await [
          Permission.camera,
          Permission.manageExternalStorage,
          Permission.storage,
        ].request();

    final denied = statuses.entries.where((e) => !e.value.isGranted).toList();

    if (denied.isNotEmpty) {
      if (state is CameraReady) {
        emit(
          (state as CameraReady).copyWith(
            snackBarMessage: 'Izin tidak diberikan',
          ),
        );
      }
    }
  }
}
