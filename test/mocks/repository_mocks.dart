import 'package:flutter_recruitment_task/movies/details/domain/models/movie_details.dart';
import 'package:flutter_recruitment_task/movies/details/domain/repositories/movie_details_repository.dart';
import 'package:flutter_recruitment_task/movies/list/domain/repositories/movie_list_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieListRepository extends Mock implements MovieListRepository {}

class MockMovieDetailsRepository extends Mock
    implements MovieDetailsRepository {}
