part of 'picker_image_bloc.dart';

abstract class PickerImageEvent extends Equatable {
  const PickerImageEvent();

  @override
  List<Object> get props => [];
}

class PickerImageInitEvent extends PickerImageEvent {}

class onSelectMultipleImageEvent extends PickerImageEvent {
//   final List<XFile> images;
//   onSelectMultipleImageEvent(this.images);

  onSelectMultipleImageEvent();
}

class onRemoveImageEvent extends PickerImageEvent {
  XFile image;

  onRemoveImageEvent(this.image);
}

class onSelevtVideoEvent extends PickerImageEvent {}

class onRemoveVideoEvent extends PickerImageEvent {}

class onTakeImageEvent extends PickerImageEvent {}
