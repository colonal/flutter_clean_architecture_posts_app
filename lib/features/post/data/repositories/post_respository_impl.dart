import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../models/post_model.dart';
import '../../domain/entites/post.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/post_repositories.dart';
import 'package:dartz/dartz.dart';

import '../datasources/post_local_data_source.dart';
import '../datasources/post_remote_data_source.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class PostsRepositoryImpl implements PostsRepository {
  final PostRemoteDateSource remoteDateSource;
  final PostLocalDateSource localDateSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl(
      {required this.remoteDateSource,
      required this.localDateSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotPost = await remoteDateSource.getAllPost();
        localDateSource.cachePost(remotPost);
        return Right(remotPost);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDateSource.getCachedPost();
        return Right(localPosts);
      } on EmptyCacheFailure {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel = PostModel(title: post.title, body: post.body);

    return await _getMessage(() => remoteDateSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _getMessage(() => remoteDateSource.deletePost(postId));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id!, title: post.title, body: post.body);

    return await _getMessage(() => remoteDateSource.updatePost(postModel));
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
