// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'picker_image_bloc.dart';

class PickerImageState extends Equatable {
  List<XFile>? images;
  XFile? video;
  String isError = '';
  String get videoPath => video?.path ?? '';
  List<String> get imagesPath => images?.map((e) => e.path).toList() ?? [];
  PickerImageState(
    this.images,
    this.video,
  );
  factory PickerImageState.initial() => PickerImageState([], null);
  @override
  // TODO: implement props
  List<Object?> get props => [images, video];

  PickerImageState copyWith({
    List<XFile>? images,
    XFile? video,
  }) {
    return PickerImageState(
      images ?? this.images,
      video ?? this.video,
    );
  }
}
