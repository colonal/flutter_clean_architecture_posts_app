import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

const BASE_URL = "https://jsonplaceholder.typicode.com/";

abstract class PostRemoteDateSource {
  Future<List<PostModel>> getAllPost();

  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);
}

class PostRemoteDataSourceImpl implements PostRemoteDateSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPost() async {
    final response = await client.get(
      Uri.parse(BASE_URL + "posts/"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List decodeJson = json.decode(response.body) as List;
      final List<PostModel> postModels =
          decodeJson.map((postJson) => PostModel.fromJson(postJson)).toList();
      return postModels;
    }
    throw ServerException();
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final postJson =
        json.encode({"title": postModel.title, "body": postModel.body});
    final response = await client.post(
      Uri.parse(BASE_URL + "posts/"),
      headers: {"Content-Type": "application/json"},
      body: postJson,
    );

    if (response.statusCode == 201) {
      return Future.value(unit);
    }

    throw ServerException();
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
      Uri.parse(BASE_URL + "posts/" + postId.toString()),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    }

    throw ServerException();
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final body = json.encode({
      "title": postModel.title,
      "body": postModel.body,
    });
    final response = await client.put(
        Uri.parse(BASE_URL + "posts/" + postModel.id.toString()),
        headers: {"Content-Type": "application/json"},
        body: body);

    if (response.statusCode == 200) {
      return Future.value(unit);
    }

    throw ServerException();
  }
}
