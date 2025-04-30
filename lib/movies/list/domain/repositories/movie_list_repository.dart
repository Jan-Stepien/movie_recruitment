import 'package:flutter_recruitment_task/movies/list/data/services/movie_list_local_service.dart';
import 'package:flutter_recruitment_task/movies/list/data/services/movie_list_remote_service.dart';
import 'package:flutter_recruitment_task/movies/list/domain/models/movie_list_item.dart';
import 'package:collection/collection.dart';

class MovieListRepository {
  final MovieListLocalService _movieListLocalService;
  final MovieListRemoteService _movieListRemoteService;

  Stream<List<MovieListItem>> get stream => _movieListLocalService.stream;

  MovieListRepository({
    required MovieListLocalService movieListLocalService,
    required MovieListRemoteService movieListRemoteService,
  })  : _movieListLocalService = movieListLocalService,
        _movieListRemoteService = movieListRemoteService;

  Future<void> searchMovies({required String query}) async {
    final results = await _movieListRemoteService.searchMovies(query: query);
    await _movieListLocalService.saveSearchResults(
      results: results.sortedByCompare(
        (movie) => movie.voteAverage,
        (a, b) => b.compareTo(a),
      ),
      shouldReplace: true,
    );
  }
}
