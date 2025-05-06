import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recruitment_task/core/movie_app.dart';
import 'package:flutter_recruitment_task/movies/list/domain/repositories/movie_list_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mocks/repository_mocks.dart';

void main() {
  group('Main App', () {
    testWidgets('initializes correctly', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});

      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<MovieListRepository>(
              create: (context) => MockMovieListRepository(),
            ),
          ],
          child: const MovieApp(),
        ),
      );

      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
