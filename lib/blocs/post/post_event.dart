// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class LoadPostEvent extends PostEvent {
  // final String last_id;
  // final int index;
  // final int count;
  // LoadPostEvent({required this.last_id, required this.index, required this.count});
  bool? isNotPost = false;
  bool? isRefresh = false;
  LoadPostEvent({this.isNotPost, this.isRefresh});
}

class AddPost extends PostEvent {
  String? described;
  List<XFile>? images;
  XFile? video;
  String? status;
  AddPost({
    this.described,
    this.images,
    this.video,
    this.status,
  });
}

class UpdatePost extends PostEvent {
  final PostModel post;
  UpdatePost({required this.post});

  @override
  List<Object> get props => [post];
}

class DeletePost extends PostEvent {
  final PostModel post;
  DeletePost({required this.post});

  @override
  List<Object> get props => [post];
}

class LoadMorePostEvent extends PostEvent {
  final String last_id;
  final int index;
  final int count;
  LoadMorePostEvent({required this.last_id, required this.index, required this.count});
}

class GetPostByIdEvent extends PostEvent {
  final String id;
  GetPostByIdEvent({required this.id});
}
