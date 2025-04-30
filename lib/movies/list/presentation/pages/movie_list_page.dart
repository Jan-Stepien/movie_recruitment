import 'package:flutter/material.dart';
import 'package:flutter_recruitment_task/movies/details/presentation/pages/movie_details_page.dart';
import 'package:flutter_recruitment_task/movies/list/domain/models/movie_list_item.dart';
import 'package:flutter_recruitment_task/movies/list/presentation/widgets/movie_card.dart';
import 'package:flutter_recruitment_task/movies/list/presentation/widgets/search_box.dart';
import 'package:flutter_recruitment_task/movies/list/data/services/movie_list_remote_service.dart';

class MovieListPage extends StatefulWidget {
  static const routePath = '/movie_list';

  const MovieListPage({super.key});

  @override
  MovieListPageState createState() => MovieListPageState();
}

class MovieListPageState extends State<MovieListPage> {
  final apiService = MovieListRemoteService();

  Future<List<MovieListItem>> _movieList = Future.value([]);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.movie_creation_outlined),
              onPressed: () {
                Navigator.pushNamed(context, MovieDetailsPage.routePath);
              },
            ),
          ],
          title: Text('Movie Browser'),
        ),
        body: Column(
          children: <Widget>[
            SearchBox(onSubmitted: _onSearchBoxSubmitted),
            Expanded(child: _buildContent()),
          ],
        ),
      );

  Widget _buildContent() => FutureBuilder<List<MovieListItem>>(
      future: _movieList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Text(snapshot.error.toString()),
          );
        } else {
          return _buildMoviesList(snapshot.data ?? []);
        }
      });

  Widget _buildMoviesList(List<MovieListItem> movies) => ListView.separated(
        separatorBuilder: (context, index) => Container(
          height: 1.0,
          color: Colors.grey.shade300,
        ),
        itemBuilder: (context, index) => MovieCard(
          title: movies[index].title,
          rating: '${(movies[index].voteAverage * 10).toInt()}%',
          onTap: () {},
        ),
        itemCount: movies.length,
      );

  void _onSearchBoxSubmitted(String text) {
    setState(() {
      if (text.isNotEmpty) {
        _movieList = apiService.searchMovies(query: text);
      } else {
        _movieList = Future.value([]);
      }
    });
  }
}
