import '../../../../core/error/failure.dart';
import '../entites/post.dart';
import '../repositories/post_repositories.dart';
import 'package:dartz/dartz.dart';

class UpdatePostUsecase {
  final PostsRepository repository;

  UpdatePostUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}
