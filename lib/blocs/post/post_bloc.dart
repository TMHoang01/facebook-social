// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_copy/constants.dart';

import 'package:fb_copy/models/post_model.dart';
import 'package:fb_copy/repositories/api_repository.dart';
import 'package:fb_copy/repositories/post_repository.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

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
    on<AddPost>(_onAddPost);
    on<EditPost>(_onEditPost);
    on<DeletePost>(_onDeletePost);
    on<GetPostByIdEvent>(_onGetPostById);
    on<LikePostEvent>(_onLikePost);
  }

  FutureOr<void> _onAddPost(AddPost event, Emitter<PostState> emit) async {
    List<PostModel> listPosts = state.listPosts ?? <PostModel>[];

    emit(PostLoadingState(listPosts: state.listPosts));

    try {
      final ApiResponse response = await repo.addPost(event.described, event.images, event.video, event.status);
      if (response.code == '1000') {
        final Map<String, dynamic> data = response.data ?? <String, dynamic>{};
        final String idNewPost = data['id'] ?? '';
        if (idNewPost.isEmpty) {
          emit(PostErrorState(message: 'Không thể thêm bài viết'));
          return;
        }

        PostModel postRaw = PostModel(
          id: idNewPost,
          described: event.described,
        );

        PostModel postServer = await _onGetPostById(GetPostByIdEvent(id: idNewPost), emit);
        // add postRaw in postServer if postServer is not null
        if (postServer.id != null) {
          postRaw = postServer.copyWith(
            image: postServer.image,
            video: postServer.video,
            status: postServer.status,
            created: postServer.created,
            modified: postServer.modified,
            author: postServer.author,
          );
        }
        Logger().d(postRaw.toJson());
        Logger().d(postServer.toJson());
        String message = 'Thêm bài viết thành công';
        final List<PostModel> listPosts = state.listPosts ?? [];
        listPosts.insert(0, postServer);
        emit(PostLoadedState(listPosts: listPosts, message: message));
      } else {
        emit(PostErrorState(message: response.message));
      }
    } catch (e) {
      Logger().d('error add post $e');
      emit(PostLoadedState(listPosts: listPosts, error: 'Kết nối server bị lỗi, vui lòng kiểm tra lại'));
    }
  }

  FutureOr<void> _onEditPost(EditPost event, Emitter<PostState> emit) async {
    final post = event.post;

    // List<PostModel> listPosts = List.from(state.listPosts)..remove(event.post);
    // Logger().d('listImageIdDelete ${event.listImageIdDelete}');
    try {
      final ApiResponse response = await repo.editPost(
        postId: event.post.id,
        described: event.described == post.described ? null : event.described,
        imagesIdDelete: event.listImageIdDelete,
        images: event.images,
        video: event.video,
        status: event.status == post.status ? null : event.status,
      );

      if (response.code == '1000') {
        String message = 'Sửa bài viết thành công';
        final List<PostModel> listPosts = state.listPosts ?? [];

        final postEdit = await _onGetPostById(GetPostByIdEvent(id: post.id.toString()), emit);
        final index = listPosts.indexWhere((element) => element.id == post.id);
        listPosts[index] = postEdit;

        emit(PostLoadedState(listPosts: listPosts, message: message));
      } else {
        emit(PostErrorState(message: response.message));
      }
    } catch (e) {
      Logger().d('error edit post $e');
      emit(PostErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _onDeletePost(DeletePost event, Emitter<PostState> emit) async {
    if (state is PostLoadedState) {
      final post = event.post;
      List<PostModel> listPosts = state.listPosts;
      try {
        String message = 'Xóa bài viết thành công';
        final ApiResponse response = await repo.deletePost(post.id.toString());
        print(" _onDeletePost :" + response.toJson().toString());
        if (response.code == '1000') {
          Logger().d(listPosts.length.toString());
          // List<PostModel> listPosts = List.from(state.listPosts)..remove(post);
          listPosts = listPosts.where((element) => element.id != post.id).toList();
          emit(PostLoadedState(listPosts: listPosts, message: message));
        } else {
          print(" _onDeletePost code != 1000 :" + response.toJson().toString());
          listPosts = List.from(listPosts);
          message = 'Có lỗi xảy ra. Xóa bài không thành công';
          emit(PostLoadedState(listPosts: listPosts, message: message));
        }
      } catch (e) {
        Logger().d('error delete post $e');
        emit(PostLoadedState(listPosts: listPosts, error: 'Kết nối server bị lỗi, không thể xóa bài viết'));
      }
    }

    // List<PostModel> listPosts = List.from(state.listPosts)..remove(event.post);
    // post.isDeleted == false ? listPosts.add(post.copyWith(isDeleted: true)) : listPosts.add(post.copyWith(isDeleted: false));
    // emit(PostLoadingState(listPosts: listPosts));
  }

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
    // print('listPosts: ${listPosts.length}');
    emit(PostLoadingState(listPosts: listPosts));
    try {
      // Logger().d(
      // 'lastId: $lastId length pre state: ${listPosts.length} limit: $limitLoadPost  isNotPost: ${event.isNotPost}');

      final ApiResponse response = await repo.getListPosts(lastId, listPosts.length, limitLoadPost, item++);
      Logger().d( response.code);
      // Logger().d(response.data);
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

        // Logger().d('legth new state post ${listPosts.length}  item $item ');
        emit(PostLoadedState(listPosts: listPosts));
      } else if (response.code == '9994') {
        print('code 9994: no more posst ' + item.toString() + ' ' + listPosts.length.toString());
        emit(PostLoadedState(listPosts: listPosts, isNotPost: true));
      } else if (response.code == '9998') {
        emit(PostExpiredTokenState());
      } else {
        print('not code 1000: ' + response.toString());
        emit(PostErrorState(message: response.message));
      }
    } catch (e) {
      Logger().e(e);
      emit(PostErrorState(message: 'Server Error :::'));
    }
  }

  FutureOr<PostModel> _onGetPostById(GetPostByIdEvent event, Emitter<PostState> emit) async {
    print('_onGetPostById event id: ${event.id}');
    // if (this.state is LoadPostEvent) {
    List<PostModel> listPosts = state.listPosts ?? <PostModel>[];

    try {
      ApiResponse response = await repo.getPost(event.id);
      if (response.code == '1000') {
        final post = PostModel.fromJson(response.data as Map<String, dynamic>);
        if (listPosts.any((element) => element.id == post.id)) {
          listPosts = listPosts.map((e) => e.id == post.id ? post : e).toList();
        }
        emit(PostLoadedState(listPosts: listPosts));
        // emit(PostElementInListState(listPosts: listPosts, findPostById: true));
        return post;
      } else if (response.code == '9998') {
        emit(PostExpiredTokenState());
      } else {
        emit(PostLoadedState(listPosts: listPosts, message: response.message));
      }
    } catch (e) {
      emit(PostElementInListState(listPosts: listPosts, findPostById: false, message: 'Server Error'));
    }
    // }
    print('_onGetPostById return PostModel(null)');
    return PostModel();
  }

  FutureOr<void> _onLikePost(LikePostEvent event, Emitter<PostState> emit) async {
    try {
      if (state is PostLoadedState) {
        final post = event.post;
        List<PostModel> listPosts = state.listPosts;
        emit(PostLoadingState(listPosts: listPosts));
        ApiResponse response = await repo.likePost(post.id.toString());
        if (response.code == '1000') {
          Logger().d('like post success ${response.data}');
          String like = response.data['like'];
          String isLike = post.isLiked == "1" ? '0' : '1';
          listPosts = listPosts
              .map((e) => e.id == post.id
                  ? post.copyWith(
                      isLiked: isLike,
                      like: like,
                    )
                  : e)
              .toList();
          emit(PostLoadedState(listPosts: listPosts));
        } else if (response.code == '9998') {
          emit(PostExpiredTokenState());
        } else {
          emit(PostLoadedState(listPosts: listPosts, message: response.message));
        }
      }
    } catch (e) {
      emit(PostLoadedState(listPosts: state.listPosts));
      Logger().d('error like post $e');
    }
  }
}

// get PostModel from post repository
