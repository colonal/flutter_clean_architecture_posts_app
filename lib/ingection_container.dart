import 'core/network/network_info.dart';
import 'features/post/data/datasources/post_local_data_source.dart';
import 'features/post/data/datasources/post_remote_data_source.dart';
import 'features/post/data/repositories/post_respository_impl.dart';
import 'features/post/domain/repositories/post_repositories.dart';
import 'features/post/domain/usecases/add_post.dart';
import 'features/post/domain/usecases/delete_post.dart';
import 'features/post/domain/usecases/get_all_posts.dart';
import 'features/post/domain/usecases/update_post.dart';
import 'features/post/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'features/post/presentation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - post

  // Bloc

  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostBloc(
      addPostUsecase: sl(), deletePostUsecase: sl(), updatePostUsecase: sl()));

  // Usecases
  sl.registerLazySingleton(() => GetAllPostesUsecase(sl()));
  sl.registerLazySingleton(() => AddPostUsecase(sl()));
  sl.registerLazySingleton(() => DeletePostUsecase(sl()));
  sl.registerLazySingleton(() => UpdatePostUsecase(sl()));

  // Repository
  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
      remoteDateSource: sl(), localDateSource: sl(), networkInfo: sl()));

  // Datasources
  sl.registerLazySingleton<PostRemoteDateSource>(
      () => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDateSource>(
      () => PostLocalDateSourceImpl(sharedPreferences: sl()));

  // core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
