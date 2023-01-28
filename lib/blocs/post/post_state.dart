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

  @override
  PostInitialSate copyWith({
    List<PostModel>? listPosts,
  }) {
    return PostInitialSate(
      listPosts: listPosts ?? this.listPosts,
    );
  }
}

class PostLoadingState extends PostState {
  @override
  final List<PostModel> listPosts;
  PostLoadingState({required this.listPosts});

  @override
  PostLoadingState copyWith({
    List<PostModel>? listPosts,
  }) {
    return PostLoadingState(
      listPosts: listPosts ?? this.listPosts,
    );
  }
}

class PostLoadedState extends PostState {
  @override
  final List<PostModel> listPosts;
  String? message;
  String? error;
  bool? isNotPost = false;

  PostLoadedState({
    required this.listPosts,
    this.isNotPost,
    this.message,
    this.error,
  });

  @override
  List<Object> get props => [listPosts];

  @override
  PostLoadedState copyWith({
    List<PostModel>? listPosts,
    bool? isNotPost,
    bool? findPostById,
    String? message,
    String? error,
  }) {
    return PostLoadedState(
      listPosts: listPosts ?? this.listPosts,
      isNotPost: isNotPost ?? this.isNotPost,
      message: message,
      error: error,
    );
  }
}

class PostElementInListState extends PostState {
  @override
  final List<PostModel> listPosts;
  String? message;
  String? error;
  @override
  bool? isNotPost = false;
  bool? findPostById = true;
  PostElementInListState({
    required this.listPosts,
    this.isNotPost,
    this.findPostById,
    this.message,
    this.error,
  });

  @override
  PostElementInListState copyWith({
    List<PostModel>? listPosts,
    bool? isNotPost,
    bool? findPostById,
    String? message,
    String? error,
  }) {
    return PostElementInListState(
      listPosts: listPosts ?? this.listPosts,
      isNotPost: isNotPost ?? this.isNotPost,
      findPostById: findPostById ?? this.findPostById,
      message: message,
      error: error,
    );
  }
}

class PostExpiredTokenState extends PostState {}

class PostErrorState extends PostState {
  final message;
  PostErrorState({this.message});
}
