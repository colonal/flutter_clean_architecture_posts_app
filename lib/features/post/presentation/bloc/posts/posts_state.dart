part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class LoadingPostState extends PostsState {}

class LoadedPostsStare extends PostsState {
  final List<Post> posts;

  const LoadedPostsStare({required this.posts});

  @override
  List<Object> get props => [posts];
}

class ErrorPostsState extends PostsState {
  final String message;

  const ErrorPostsState({required this.message});
  @override
  List<Object> get props => [];
}
