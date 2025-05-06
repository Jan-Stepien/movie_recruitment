import 'package:flutter_recruitment_task/movies/details/domain/models/movie_details.dart';
import 'package:flutter_recruitment_task/movies/details/domain/repositories/movie_details_repository.dart';
import 'package:flutter_recruitment_task/movies/list/domain/models/movie_list_item.dart';
import 'package:flutter_recruitment_task/movies/list/domain/repositories/movie_list_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieListRepository extends Mock implements MovieListRepository {
  @override
  Stream<List<MovieListItem>> get stream => Stream.value([]);
}

class MockMovieDetailsRepository extends Mock
    implements MovieDetailsRepository {
  @override
  Stream<MovieDetails?> get stream => Stream.value(null);
}
