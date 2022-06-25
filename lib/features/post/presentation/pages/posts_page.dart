import 'dart:ui';

import '../bloc/posts/posts_bloc.dart';
import 'post_add_update_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../widgets/posts_page/message_display.dart';
import '../widgets/posts_page/posts_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingButton(context),
    );
  }

  AppBar _buildAppbar() => AppBar(title: const Text("Posts"));

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostState) {
            return const LoadingWidget();
          } else if (state is LoadedPostsStare) {
            return RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      },
                    ),
                    child: PostListWidget(posts: state.posts)));
          } else if (state is ErrorPostsState) {
            return MessageDisplayWidget(
              message: state.message,
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Widget _buildFloatingButton(context) {
    return FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const PostAddUpdatePage())));
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }
}
