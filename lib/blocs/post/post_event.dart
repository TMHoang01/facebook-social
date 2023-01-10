part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class AddPost extends PostEvent {
  final PostModel post;
  AddPost({required this.post});

  @override
  List<Object> get props => [post];
}

class UpdatePost extends PostEvent {
  final PostModel post;
  UpdatePost({required this.post});

  @override
  List<Object> get props => [post];
}

class DaletePost extends PostEvent {
  final PostModel post;
  DaletePost({required this.post});

  @override
  List<Object> get props => [post];
}
