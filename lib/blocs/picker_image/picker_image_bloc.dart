import 'dart:io';

import 'package:fb_copy/models/post_model.dart';
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
    on<PickerImageEditPostEvent>((event, emit) {
      emit(PickerImageState.editPost(event.post));
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
      String? message;

      List<ImageModel> oldImages = state.oldImages ?? [];
      if (oldImages.length > 4) {
        oldImages = oldImages.sublist(0, 4);
        message = 'Chỉ được chọn tối đa 4 ảnh cho 1 bài viết';
        emit(state.copyWith(oldImages: oldImages, message: message));
        return;
      }
      List<XFile> images = await _picker.pickMultiImage();
      // limit 4 images
      int countImages = images.length + oldImages.length;

      if (countImages > 4) {
        int end = 4 - oldImages.length;
        if (end < 0) end = 0;
        images = images.sublist(0, end);
        message = 'Chỉ được chọn tối đa 4 ảnh cho 1 bài viết';
      }
      if (images != null) {
        emit(state.copyWith(images: images, oldImages: oldImages, message: message));
      }
    } catch (e) {
      Logger().e(e);
      print(e);
    }
  }

  Future<void> _onRemoveImage(onRemoveImageEvent event, Emitter<PickerImageState> emit) async {
    try {
      final images = state.images;
      final oldImages = state.oldImages;
      if (images != null) {
        List<XFile> newImages = List.from(images);
        newImages.remove(event.image);
        Logger().d(newImages);
        emit(state.copyWith(images: newImages));
      }
      if (oldImages != null) {
        List<ImageModel> newOldImages = List.from(oldImages);
        newOldImages.remove(event.oldImage);
        Logger().d(newOldImages);
        emit(state.copyWith(oldImages: newOldImages));
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
