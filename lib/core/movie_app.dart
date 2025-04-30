import 'package:flutter/material.dart';
import 'package:flutter_recruitment_task/movies/details/presentation/pages/movie_details_page.dart';
import 'package:flutter_recruitment_task/movies/list/presentation/pages/movie_list_page.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Movie Browser',
        theme: ThemeData(primarySwatch: Colors.amber),
        initialRoute: MovieListPage.routePath,
        routes: {
          MovieListPage.routePath: (context) => MovieListPage(),
          MovieDetailsPage.routePath: (context) => MovieDetailsPage(
                movieId: ModalRoute.of(context)?.settings.arguments as int,
              ),
        },
      );
}
