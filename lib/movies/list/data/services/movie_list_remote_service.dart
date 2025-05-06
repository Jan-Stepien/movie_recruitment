import 'dart:convert';

import 'package:flutter_recruitment_task/movies/list/domain/models/movie_list_item.dart';
import 'package:flutter_recruitment_task/movies/list/data/models/movie_list.dart';
import 'package:http/http.dart' as http;

class MovieListRemoteService {
  final String _apiKey;
  final String _baseUrl;

  MovieListRemoteService({
    required String apiKey,
    required String baseUrl,
  })  : _apiKey = apiKey,
        _baseUrl = baseUrl;

  Future<List<MovieListItem>> searchMovies({required String query}) async {
    final parameters = {
      'api_key': _apiKey,
      'query': query,
    };

    final endpoint = Uri.https(_baseUrl, '/3/search/movie', parameters);

    final response = await http.get(endpoint);
    final json = jsonDecode(response.body);
    final movieList = MovieList.fromJson(json);
    return movieList.results;
  }
}
