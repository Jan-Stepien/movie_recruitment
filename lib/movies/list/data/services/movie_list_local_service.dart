import 'dart:async';
import 'dart:convert';

import 'package:flutter_recruitment_task/movies/list/domain/models/movie_list_item.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieListLocalService {
  static const _searchHistoryKey = 'k_movie_search_history';

  final SharedPreferences _storage;

  late final StreamController<List<MovieListItem>> _streamController =
      BehaviorSubject.seeded(getResults());
  Stream<List<MovieListItem>> get stream => _streamController.stream;

  MovieListLocalService({
    required SharedPreferences storage,
  }) : _storage = storage;

  Future<void> saveSearchResults({
    required List<MovieListItem> results,
    required bool shouldReplace,
  }) async {
    if (shouldReplace) {
      await _storage.remove(_searchHistoryKey);
    }
    final resultsJson = results.map((movie) => movie.toJson()).toList();
    await _storage.setString(_searchHistoryKey, jsonEncode(resultsJson));
  }

  List<MovieListItem> getResults() {
    final listJson = _storage.getString(_searchHistoryKey);
    if (listJson == null) return [];

    final results = jsonDecode(listJson);
    return results.map((json) => MovieListItem.fromJson(json)).toList();
  }

  Future<void> clear() async {
    await _storage.remove(_searchHistoryKey);
  }
}
