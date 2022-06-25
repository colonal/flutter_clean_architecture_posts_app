import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entites/post.dart';
import '../repositories/post_repositories.dart';

class GetAllPostesUsecase {
  final PostsRepository repository;
  GetAllPostesUsecase(this.repository);

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}
