part of 'camera_bloc.dart';

sealed class CameraState {}

final class CameraInitial extends CameraState {}

final class CameraReady extends CameraState {
  final CameraController controller;
  final int selectedIndex;
  final FlashMode flashMode;
  final File? imageFile;
  final String? snackBarMessage;

  CameraReady({
    required this.controller,
    required this.selectedIndex,
    required this.flashMode,
    this.imageFile,
    this.snackBarMessage,
  });

  CameraReady copyWith({
    CameraController? controller,
    int? selectedIndex,
    FlashMode? flashMode,
    File? imageFile,
    String? snackBarMessage,
    bool ClearSnackBar = false,
  }) {
    return CameraReady(
      controller: controller ?? this.controller,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      flashMode: flashMode ?? this.flashMode,
      imageFile: imageFile ?? this.imageFile,
      snackBarMessage:
          ClearSnackBar ? null : snackBarMessage ?? this.snackBarMessage,
    );
  }
}
