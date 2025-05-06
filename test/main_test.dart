import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recruitment_task/core/movie_app.dart';
import 'package:flutter_recruitment_task/movies/details/domain/models/movie_details.dart';
import 'package:flutter_recruitment_task/movies/details/domain/repositories/movie_details_repository.dart';
import 'package:flutter_recruitment_task/movies/details/presentation/pages/movie_details_page.dart';
import 'package:flutter_recruitment_task/movies/list/domain/models/movie_list_item.dart';
import 'package:flutter_recruitment_task/movies/list/domain/repositories/movie_list_repository.dart';
import 'package:flutter_recruitment_task/movies/list/presentation/widgets/movie_list_card.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mocks/repository_mocks.dart';

void main() {
  late MockMovieListRepository mockMovieListRepository;
  setUp(() {
    mockMovieListRepository = MockMovieListRepository();
    when(() => mockMovieListRepository.stream).thenAnswer(
      (_) => Stream<List<MovieListItem>>.value(
        [],
      ),
    );
  });
  group('Main App', () {
    testWidgets('initializes correctly', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});

      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<MovieListRepository>(
              create: (context) => mockMovieListRepository,
            ),
          ],
          child: const MovieApp(),
        ),
      );

      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('push movie details page on movie item pressed',
        (WidgetTester tester) async {
      late MockMovieDetailsRepository mockMovieDetailsRepository =
          MockMovieDetailsRepository();
      when(() => mockMovieDetailsRepository.stream).thenAnswer(
        (_) => Stream<MovieDetails?>.value(null),
      );

      when(() => mockMovieListRepository.stream).thenAnswer(
        (_) => Stream<List<MovieListItem>>.value(
            [MovieListItem(id: 1, title: 'Test Movie', voteAverage: 8.5)]),
      );
      when(() =>
              mockMovieListRepository.searchMovies(query: any(named: 'query')))
          .thenAnswer((_) async {});
      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<MovieListRepository>(
              create: (context) => mockMovieListRepository,
            ),
            RepositoryProvider<MovieDetailsRepository>(
              create: (context) => mockMovieDetailsRepository,
            ),
          ],
          child: const MovieApp(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(MovieListCard));
      await tester.pumpAndSettle();

      expect(find.byType(MovieDetailsPage), findsOneWidget);
    });
  });
}
