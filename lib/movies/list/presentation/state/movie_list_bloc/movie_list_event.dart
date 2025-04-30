part of 'movie_list_bloc.dart';

abstract class MovieListEvent {}

class SearchMovies extends MovieListEvent {
  final String query;

  SearchMovies(this.query);
}

class ResultChanged extends MovieListEvent {
  final List<MovieListItem> movies;

  ResultChanged(this.movies);
}
