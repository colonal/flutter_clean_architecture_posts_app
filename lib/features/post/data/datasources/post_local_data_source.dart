import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/post_model.dart';

const CACHED_POSTS = "CACHED_POSTS";

abstract class PostLocalDateSource {
  Future<List<PostModel>> getCachedPost();

  Future<Unit> cachePost(List<PostModel> postModel);
}

class PostLocalDateSourceImpl implements PostLocalDateSource {
  final SharedPreferences sharedPreferences;

  PostLocalDateSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachePost(List<PostModel> postModel) {
    List postModelToJson = postModel.map((post) => post.toJson()).toList();

    sharedPreferences.setString(CACHED_POSTS, json.encode(postModelToJson));

    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPost() {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);

    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodeJsonData
          .map<PostModel>((jsonPost) => PostModel.fromJson(jsonPost))
          .toList();

      return Future.value(jsonToPostModels);
    }

    return throw EmptyCacheException();
  }
}
