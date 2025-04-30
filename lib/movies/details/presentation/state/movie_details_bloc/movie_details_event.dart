part of 'movie_details_bloc.dart';

abstract class MovieDetailsEvent {}

class FetchMovieDetails extends MovieDetailsEvent {
  final int movieId;

  FetchMovieDetails(this.movieId);
}

class DetailsChanged extends MovieDetailsEvent {
  final MovieDetails? details;

  DetailsChanged(this.details);
}
