// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  List<CommentModel> listComments;
  CommentState(
    this.listComments,
  );

  @override
  List<Object> get props => [];
}

class CommentInitialState extends CommentState {
  CommentInitialState(super.listComments);
}

class CommentInitialSate extends CommentState {
  final List<CommentModel> listComments;
  CommentInitialSate({required this.listComments}) : super(listComments);
  @override
  List<Object> get props => [listComments];

  @override
  CommentInitialSate copyWith({
    List<CommentModel>? listComments,
  }) {
    return CommentInitialSate(
      listComments: listComments ?? this.listComments,
    );
  }
}

class CommentLoadingState extends CommentState {
  @override
  final List<CommentModel> listComments;
  CommentLoadingState({required this.listComments}) : super(listComments);

  @override
  CommentLoadingState copyWith({
    List<CommentModel>? listComments,
  }) {
    return CommentLoadingState(
      listComments: listComments ?? this.listComments,
    );
  }
}

class CommentLoadedState extends CommentState {
  @override
  final List<CommentModel> listComments;
  String? message;
  String? error;
  bool? isNotComment = false;

  CommentLoadedState({
    required this.listComments,
    this.message,
    this.error,
    this.isNotComment,
  }) : super(listComments);

  @override
  List<Object> get props => [listComments];

  @override
  CommentLoadedState copyWith({
    List<CommentModel>? listComments,
    bool? isNotComment,
    bool? findCommentById,
    String? message,
    String? error,
  }) {
    return CommentLoadedState(
      listComments: listComments ?? this.listComments,
      isNotComment: isNotComment ?? this.isNotComment,
      message: message,
      error: error,
    );
  }
}

class CommentErrorState extends CommentState {
  final String? message;
  final String? error;
  CommentErrorState({this.message, this.error}) : super([]);

  @override
  List<Object> get props => [];
}
