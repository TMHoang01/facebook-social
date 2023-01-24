// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'picker_image_bloc.dart';

class PickerImageState extends Equatable {
  List<XFile>? images;
  List<ImageModel>? oldImages;
  XFile? video;
  VideoModel? oldVideo;
  String? message;
  List<String> get imagesPath => images?.map((e) => e.path).toList() ?? [];
  PickerImageState({
    this.images,
    this.oldImages,
    this.oldVideo,
    this.video,
    this.message,
  });
  factory PickerImageState.initial() => PickerImageState();

  factory PickerImageState.editPost(PostModel post) {
    return PickerImageState(oldImages: post.image, oldVideo: post.video);
  }
  @override
  // TODO: implement props
  List<Object?> get props => [images, video, message, oldImages, oldVideo];

  PickerImageState copyWith({
    List<XFile>? images,
    XFile? video,
    String? message,
    List<ImageModel>? oldImages,
    VideoModel? oldVideo,
  }) {
    return PickerImageState(
      images: images ?? this.images,
      oldImages: oldImages ?? this.oldImages,
      video: video ?? this.video,
      oldVideo: oldVideo ?? this.oldVideo,
      message: message,
    );
  }
}
