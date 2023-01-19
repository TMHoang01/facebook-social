// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'post_bloc.dart';

class PostState extends Equatable {
  final List<PostModel> listPosts;
  const PostState({
    this.listPosts = const <PostModel>[],
  });

  @override
  List<Object> get props => [listPosts];

  get isNotPost => null;

  PostState copyWith({
    List<PostModel>? listPosts,
  }) {
    return PostState(
      listPosts: listPosts ?? this.listPosts,
    );
  }
}

class PostInitialSate extends PostState {
  final List<PostModel> listPosts;
  PostInitialSate({required this.listPosts});

  @override
  List<Object> get props => [listPosts];

  PostInitialSate copyWith({
    List<PostModel>? listPosts,
  }) {
    return PostInitialSate(
      listPosts: listPosts ?? this.listPosts,
    );
  }
}

class PostLoadingState extends PostState {
  final List<PostModel> listPosts;
  PostLoadingState({required this.listPosts});

  PostLoadingState copyWith({
    List<PostModel>? listPosts,
  }) {
    return PostLoadingState(
      listPosts: listPosts ?? this.listPosts,
    );
  }
}

class PostLoadedState extends PostState {
  final List<PostModel> listPosts;
  String? message;
  String? errror;
  bool? isNotPost = false;
  bool? findPostById = true;
  PostLoadedState({
    required this.listPosts,
    this.isNotPost,
    this.findPostById,
    this.message,
    this.errror,
  });

  PostLoadedState copyWith({
    List<PostModel>? listPosts,
    bool? isNotPost,
    bool? findPostById,
    String? message,
    String? errror,
  }) {
    return PostLoadedState(
      listPosts: listPosts ?? this.listPosts,
      isNotPost: isNotPost ?? this.isNotPost,
      findPostById: findPostById ?? this.findPostById,
      message: message ?? this.message,
      errror: errror ?? this.errror,
    );
  }
}

class PostErrorState extends PostState {
  final message;
  PostErrorState({this.message});
}
