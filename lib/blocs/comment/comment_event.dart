part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class LoadCommentEvent extends CommentEvent {
  bool? isNotComment = false;
  bool? isRefresh = false;
  LoadCommentEvent({this.isNotComment, this.isRefresh});
}

class AddCommentEvent extends CommentEvent {
  String? comment;
  AddCommentEvent({
    this.comment,
  });
}

class LoadMoreCommentEvent extends CommentEvent {
  bool? isNotComment = false;
  bool? isRefresh = false;
  LoadMoreCommentEvent({this.isNotComment, this.isRefresh});
}
