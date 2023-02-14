part of 'picker_image_bloc.dart';

abstract class PickerImageEvent extends Equatable {
  const PickerImageEvent();

  @override
  List<Object> get props => [];
}

class PickerImageInitEvent extends PickerImageEvent {}

class PickerImageEditPostEvent extends PickerImageEvent {
  final PostModel post;

  PickerImageEditPostEvent(this.post);
}

class onSelectMultipleImageEvent extends PickerImageEvent {
  // final List<XFile> images;
  // onSelectMultipleImageEvent(this.images);

  onSelectMultipleImageEvent();
}

class onTakeImageEvent extends PickerImageEvent {}

class onRemoveImageEvent extends PickerImageEvent {
  XFile? image;
  ImageModel? oldImage;
  onRemoveImageEvent({this.image, this.oldImage});
}

class onSelevtVideoEvent extends PickerImageEvent {}

class onRemoveVideoEvent extends PickerImageEvent {}
