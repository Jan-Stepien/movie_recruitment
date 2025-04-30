import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recruitment_task/movies/list/data/services/movie_list_local_service.dart';
import 'package:flutter_recruitment_task/movies/list/data/services/movie_list_remote_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppServiceProvider extends StatelessWidget {
  const AppServiceProvider({
    super.key,
    required this.child,
    required this.sharedPreferences,
  });

  final Widget child;
  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => MovieListLocalService(
            storage: sharedPreferences,
          ),
        ),
        RepositoryProvider(
          create: (context) => MovieListRemoteService(),
        ),
      ],
      child: child,
    );
  }
}
