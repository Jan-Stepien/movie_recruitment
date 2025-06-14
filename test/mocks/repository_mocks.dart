import 'package:movie_master_detail/movies/details/domain/repositories/movie_details_repository.dart';
import 'package:movie_master_detail/movies/list/domain/repositories/movie_list_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieListRepository extends Mock implements MovieListRepository {}

class MockMovieDetailsRepository extends Mock
    implements MovieDetailsRepository {}
