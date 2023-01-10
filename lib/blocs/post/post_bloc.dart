import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_copy/models/post_model.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<AddPost>(_onAddTask);
    on<UpdatePost>(_onUpdateTask);
    on<DaletePost>(_onDeleteTask);
  }

  FutureOr<void> _onAddTask(AddPost event, Emitter<PostState> emit) {
    final state = this.state;
    emit(PostState(
      allPosts: List.from(state.allPosts)..add(event.post),
    ));
  }

  FutureOr<void> _onUpdateTask(UpdatePost event, Emitter<PostState> emit) {}

  FutureOr<void> _onDeleteTask(DaletePost event, Emitter<PostState> emit) {}
}
