import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

part 'picker_image_event.dart';
part 'picker_image_state.dart';

class PickerImageBloc extends Bloc<PickerImageEvent, PickerImageState> {
  final ImagePicker _picker;
  // PickerImageBloc(this._picker);
  PickerImageBloc(this._picker) : super(PickerImageState.initial()) {
    on<PickerImageEvent>((event, emit) {});
    on<PickerImageInitEvent>((event, emit) {
      emit(PickerImageState.initial());
    });
    on<onSelectMultipleImageEvent>((_onSelectMultipleImages));
    on<onRemoveImageEvent>(_onRemoveImage);
    on<onSelevtVideoEvent>((_onSelectVideo));
    on<onRemoveVideoEvent>((event, emit) {
      emit(state.copyWith(video: null));
    });
    on<onTakeImageEvent>((_onTakeImage));
  }
  Future<void> _onSelectMultipleImages(onSelectMultipleImageEvent event, Emitter<PickerImageState> emit) async {
    try {
      List<XFile> images = await _picker.pickMultiImage();
      if (images != null) {
        emit(state.copyWith(images: images));
      }
    } catch (e) {
      Logger().e(e);
      print(e);
    }
  }

  Future<void> _onRemoveImage(onRemoveImageEvent event, Emitter<PickerImageState> emit) async {
    try {
      final images = state.images;
      if (images != null) {
        List<XFile> newImages = List.from(images);
        newImages.remove(event.image);
        emit(state.copyWith(images: newImages));
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> _onSelectVideo(onSelevtVideoEvent event, Emitter<PickerImageState> emit) async {
    try {
      final video = await _picker.pickVideo(source: ImageSource.gallery);
      if (video != null) {
        emit(state.copyWith(video: video));
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> _onTakeImage(onTakeImageEvent event, Emitter<PickerImageState> emit) async {
    try {
      final image = await _picker.pickImage(source: ImageSource.camera);
      List<XFile>? images;
      if (image != null) {
        images = [image];
      }
      if (image != null) {
        emit(state.copyWith(images: images));
      }
    } catch (e) {
      Logger().e(e);
    }
  }
}
