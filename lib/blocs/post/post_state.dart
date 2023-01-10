// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'post_bloc.dart';

class PostState extends Equatable {
  final List<PostModel> allPosts;
  const PostState({
    this.allPosts = const <PostModel>[],
  });

  @override
  List<Object> get props => [allPosts];
}

class PostInitial extends PostState {}
