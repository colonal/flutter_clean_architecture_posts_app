import '../../../../core/error/failure.dart';
import '../repositories/post_repositories.dart';
import 'package:dartz/dartz.dart';

class DeletePostUsecase {
  final PostsRepository repository;

  DeletePostUsecase(this.repository);

  Future<Either<Failure, Unit>> call(int postId) async {
    return await repository.deletePost(postId);
  }
}
