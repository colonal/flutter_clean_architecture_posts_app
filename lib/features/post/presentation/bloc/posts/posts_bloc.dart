import 'package:bloc/bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/entites/post.dart';
import '../../../domain/usecases/get_all_posts.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/string/failures.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostesUsecase getAllPosts;
  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostState());

        final failureOrPost = await getAllPosts();
        emit(_mapFailureOrPostsToState(failureOrPost));
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostState());
        final failureOrPost = await getAllPosts();
        emit(_mapFailureOrPostsToState(failureOrPost));
      }
    });
  }

  PostsState _mapFailureOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
        (failuer) => ErrorPostsState(message: _mapFailureToMessage(failuer)),
        (posts) => LoadedPostsStare(posts: posts));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILUERE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error, Please try again later.";
    }
  }
}
