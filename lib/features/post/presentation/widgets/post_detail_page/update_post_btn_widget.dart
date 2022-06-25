import 'package:flutter/material.dart';

import '../../../domain/entites/post.dart';
import '../../pages/post_add_update_page.dart';

class UpdatePostWidget extends StatelessWidget {
  final Post post;
  const UpdatePostWidget({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => PostAddUpdatePage(isUpdatePost: true, post: post)));
      },
      icon: const Icon(Icons.edit),
      label: const Text("Edit"),
    );
  }
}
