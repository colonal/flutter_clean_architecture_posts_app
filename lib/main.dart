import 'core/theme/app_theme.dart';
import 'features/post/presentation/bloc/posts/posts_bloc.dart';
import 'features/post/presentation/pages/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/post/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'ingection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (_) => di.sl<AddDeleteUpdatePostBloc>()),
      ],
      child: MaterialApp(
        title: 'Postes App',
        theme: AppTheme.light,
        debugShowCheckedModeBanner: false,
        home: const PostsPage(),
      ),
    );
  }
}
