// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_copy/constants.dart';

import 'package:fb_copy/models/post_model.dart';
import 'package:fb_copy/repositories/api_repository.dart';
import 'package:fb_copy/repositories/post_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  static const int limitLoadPost = 6;
  String lastId = '';
  String newItem = '0';
  int item = 1; // khong co ich chi de test
  PostRepository repo;
  PostBloc(
    this.repo,
  ) : super(PostInitialSate(listPosts: [])) {
    on<LoadPostEvent>(_onLoadingPost);
    on<AddPost>(_onAddTask);
    on<UpdatePost>(_onUpdateTask);
    on<DeletePost>(_onDeleteTask);
    on<GetPostByIdEvent>(_onGetPostById);
    // on<LoadMorePostEvent>(_onLoadMorePost);
  }

  FutureOr<void> _onAddTask(AddPost event, Emitter<PostState> emit) async {
    List<PostModel> listPosts = state.listPosts ?? <PostModel>[];

    emit(PostLoadingState(listPosts: state.listPosts));

    Logger()
        .d('add post ${state.listPosts.length}  \n add post : ${event.described} \n ${event.images} \n ${event.video}');

    // try {
    final ApiResponse response = await repo.addPost(event.described, event.images, event.video, event.status);
    if (response.code == '1000') {
      final Map<String, dynamic> data = response.data ?? <String, dynamic>{};
      final String idNewPost = data['id'] ?? '';
      if (idNewPost.isEmpty) {
        emit(PostErrorState(message: 'Không thể thêm bài viết'));
        return;
      }
      // add event get post by id
      add(GetPostByIdEvent(id: idNewPost));
      PostModel post = PostModel(
        id: idNewPost,
        described: event.described,
      );
      final List<PostModel> listPosts = state.listPosts ?? [];
      listPosts.insert(0, post);
      emit(PostLoadedState(listPosts: listPosts));
    } else {
      emit(PostErrorState(message: response.message));
    }
    // } catch (e) {
    //   emit(PostErrorState(message: e.toString()));
    // }
  }

  FutureOr<void> _onUpdateTask(UpdatePost event, Emitter<PostState> emit) {}

  FutureOr<void> _onDeleteTask(DeletePost event, Emitter<PostState> emit) {}

  FutureOr<void> _onLoadingPost(LoadPostEvent event, Emitter<PostState> emit) async {
    if (event.isNotPost == true) {
      emit(PostLoadedState(listPosts: [], isNotPost: true));
      return;
    }
    List<PostModel> listPosts = state.listPosts ?? <PostModel>[];

    if (event.isRefresh == true) {
      lastId = '';
      newItem = '0';
      item = 1;
      listPosts = <PostModel>[];
    }
    print('listPosts: ${listPosts.length}');
    emit(PostLoadingState(listPosts: listPosts));
    try {
      Logger().d(
          'lastId: $lastId length pre state: ${listPosts.length} limit: $limitLoadPost  isNotPost: ${event.isNotPost}');

      final ApiResponse response = await repo.getListPosts(lastId, listPosts.length, limitLoadPost, item++);
      Logger().d(response.code);
      // response.code = '1000';
      if (response.code == '1000') {
        final Map<String, dynamic> data = response.data ?? <String, dynamic>{};
        final List? posts = data['posts'] as List<dynamic>?;
        lastId = data['last_id'] ?? lastId;

        if (posts != null) {
          listPosts = List.from(listPosts)
            ..addAll(posts.map<PostModel>((dynamic e) => PostModel.fromJson(e as Map<String, dynamic>)).toList());
        } else {
          emit(PostErrorState(message: 'Có lỗi xảy ra vui lòng thử lại sau'));
        }

        Logger().d('legth new state post ${listPosts.length}  item $item ');
        emit(PostLoadedState(listPosts: listPosts));
      } else if (response.code == '9994') {
        print('code 9994 :' + item.toString() + ' ' + listPosts.length.toString());
        emit(PostLoadedState(listPosts: listPosts, isNotPost: true));
      } else {
        print('not code 1000: ' + response.toString());
        emit(PostErrorState(message: response.message));
      }
    } catch (e) {
      Logger().e(e);
      emit(PostErrorState(message: 'Server Error :::'));
    }
  }

  FutureOr<PostModel> _onGetPostById(GetPostByIdEvent event, Emitter<PostState> emit) {
    if (this.state is LoadPostEvent) {
      List<PostModel> listPosts = state.listPosts ?? <PostModel>[];

      try {
        repo.getPostById(event.id).then((ApiResponse response) {
          if (response.code == '1000') {
            final Map<String, dynamic> data = response.data ?? <String, dynamic>{};
            final PostModel post = PostModel.fromJson(data);
            return post;
          } else {}
        });
      } catch (e) {
        emit(PostLoadedState(listPosts: listPosts, findPostById: false));
      }
    }
    return PostModel();
  }
}

// get PostModel from post repository
