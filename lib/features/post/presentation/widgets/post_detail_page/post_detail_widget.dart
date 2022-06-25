import '../../../../../core/util/snackbar_message.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../domain/entites/post.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import '../../pages/post_add_update_page.dart';
import '../../pages/posts_page.dart';
import 'update_post_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'delete_dialog_widget.dart';
import 'delete_post_btn_widget.dart';

class PostsDetailWidget extends StatelessWidget {
  final Post post;
  const PostsDetailWidget({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            post.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 50),
          Text(
            post.body,
            style: const TextStyle(fontSize: 16),
          ),
          const Divider(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UpdatePostWidget(post: post),
              DeletePostWidget(postId: post.id!),
            ],
          )
        ],
      ),
    );
  }
}
