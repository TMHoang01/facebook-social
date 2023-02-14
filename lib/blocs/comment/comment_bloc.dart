// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import 'package:fb_copy/blocs/post/post_bloc.dart';
import 'package:fb_copy/models/comment_model.dart';
import 'package:fb_copy/models/post_model.dart';
import 'package:fb_copy/repositories/api_repository.dart';
import 'package:fb_copy/repositories/comment_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  PostModel postModel;
  CommentRepository commentRepository;
  int index = 0;
  int count = 10;
  int newCommentCount = 0;

  CommentBloc({
    required this.postModel,
    required this.commentRepository,
  }) : super(CommentInitialState([])) {
    on<CommentEvent>((event, emit) {});
    on<LoadCommentEvent>(_onLoadComment);
    on<LoadMoreCommentEvent>(_onLoadMoreComment);
    on<AddCommentEvent>(_onAddComment);
  }

  FutureOr<void> _onLoadComment(LoadCommentEvent event, Emitter<CommentState> emit) async {
    if (event.isNotComment == true) {
      emit(CommentLoadedState(listComments: [], isNotComment: true));
      return;
    }
    List<CommentModel> listComments = state.listComments ?? <CommentModel>[];

    try {
      final ApiResponse response = await commentRepository.getComment(
        id: postModel.id!,
        index: listComments.length.toString(),
        count: count.toString(),
      );
      int dataLength = response.data?.length ?? 0;
      if (response.code == '1000') {
        final List<dynamic> data = response.data ?? <dynamic>[];
        if (data.isEmpty) {
          emit(CommentLoadedState(listComments: listComments, isNotComment: true));
          return;
        }

        for (final dynamic item in data) {
          final Map<String, dynamic> itemMap = item as Map<String, dynamic>;
          final CommentModel commentModel = CommentModel.fromJson(itemMap);
          listComments.add(commentModel);
        }
      } else if (response.code == '9994') {
        emit(CommentLoadedState(listComments: listComments, isNotComment: true));
        return;
      }
      emit(CommentLoadedState(listComments: listComments, isNotComment: count == dataLength));
    } catch (e) {
      emit(CommentLoadedState(listComments: [], error: e.toString()));
    }
  }

  FutureOr<void> _onAddComment(AddCommentEvent event, Emitter<CommentState> emit) async {
    if (state is CommentLoadedState) {
      List<CommentModel> listComments = state.listComments ?? <CommentModel>[];
      // emit(CommentLoadingState(listComments: listComments));
      Logger().d(postModel.id!);
      try {
        final ApiResponse response = await commentRepository.setComment(
          id: postModel.id!,
          comment: event.comment.toString(),
          index: listComments.length.toString(),
          count: count.toString(),
        );
        Logger().i(response);
        if (response.code == '1000') {
          final List<dynamic> data = response.data ?? <dynamic>[];
          if (data.isEmpty) {
            emit(CommentLoadedState(listComments: listComments, isNotComment: true));
            return;
          }
          List<CommentModel> newComment = data.map((e) => CommentModel.fromJson(e)).toList();
          newCommentCount = newComment.length;
          listComments = listComments + newComment;
        }
        emit(CommentLoadedState(listComments: listComments));
      } catch (e) {
        emit(CommentLoadedState(listComments: [], error: e.toString()));
      }
    }
  }

  FutureOr<void> _onLoadMoreComment(LoadMoreCommentEvent event, Emitter<CommentState> emit) async {
    if (state is CommentLoadedState) {
      List<CommentModel> listComments = state.listComments ?? <CommentModel>[];
      emit(CommentLoadingState(listComments: listComments));
      try {
        final ApiResponse response = await commentRepository.getComment(
          id: postModel.id!,
          index: listComments.length.toString(),
          count: count.toString(),
        );
        Logger().i(response);
        if (response.code == '1000') {
          final List<dynamic> data = response.data ?? <dynamic>[];
          if (data.isEmpty) {
            Logger().i('empty');
            emit(CommentLoadedState(listComments: listComments, isNotComment: true));
            return;
          }
          for (final dynamic item in data) {
            final Map<String, dynamic> itemMap = item as Map<String, dynamic>;
            final CommentModel commentModel = CommentModel.fromJson(itemMap);
            listComments.add(commentModel);
          }
          bool isNotComment = (count == data.length);
          emit(CommentLoadedState(listComments: listComments, isNotComment: isNotComment));
        } else if (response.code == '9994') {
          emit(CommentLoadedState(listComments: listComments, isNotComment: true));
          return;
        } else {
          emit(CommentLoadedState(listComments: listComments));
        }
      } catch (e) {
        emit(CommentLoadedState(listComments: [], error: e.toString()));
      }
    }
  }
}
