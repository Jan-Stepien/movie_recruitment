import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recruitment_task/movies/list/data/services/movie_list_local_service.dart';
import 'package:flutter_recruitment_task/movies/list/data/services/movie_list_remote_service.dart';
import 'package:flutter_recruitment_task/movies/list/domain/repositories/movie_list_repository.dart';

class AppRepositoryProvider extends StatelessWidget {
  const AppRepositoryProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final movieListLocalService = context.read<MovieListLocalService>();
    final movieListRemoteService = context.read<MovieListRemoteService>();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => MovieListRepository(
            movieListLocalService: movieListLocalService,
            movieListRemoteService: movieListRemoteService,
          ),
        ),
      ],
      child: child,
    );
  }
}
