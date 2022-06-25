import 'package:bloc/bloc.dart';
import '../../../domain/entites/post.dart';
import '../../../domain/usecases/add_post.dart';
import '../../../domain/usecases/delete_post.dart';
import '../../../domain/usecases/update_post.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/string/failures.dart';
import '../../../../../core/string/messages.dart';

part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUsecase addPostUsecase;
  final DeletePostUsecase deletePostUsecase;
  final UpdatePostUsecase updatePostUsecase;
  AddDeleteUpdatePostBloc(
      {required this.addPostUsecase,
      required this.deletePostUsecase,
      required this.updatePostUsecase})
      : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LodingAddDeleteUpdatePostState());
        final failuerOrDoneMessage = await addPostUsecase(event.post);

        emit(_eitherDoneMessageOrErrorState(
            either: failuerOrDoneMessage, message: ADD_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        emit(LodingAddDeleteUpdatePostState());

        final failuerOrDoneMessage = await updatePostUsecase(event.post);

        emit(_eitherDoneMessageOrErrorState(
            either: failuerOrDoneMessage, message: UPDATE_SUCCESS_MESSAG));
      } else if (event is DeletePostEvent) {
        emit(LodingAddDeleteUpdatePostState());

        final failuerOrDoneMessage = await deletePostUsecase(event.postId);

        emit(_eitherDoneMessageOrErrorState(
            either: failuerOrDoneMessage, message: DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILUERE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error, Please try again later.";
    }
  }

  AddDeleteUpdatePostState _eitherDoneMessageOrErrorState(
      {required Either<Failure, Unit> either, required String message}) {
    return either.fold(
        (failuer) => ErrorAddDeleteUpdatePostState(
            message: _mapFailureToMessage(failuer)),
        (_) => const MessageAddDeleteUpdatePostState(
            message: ADD_SUCCESS_MESSAGE));
  }
}
