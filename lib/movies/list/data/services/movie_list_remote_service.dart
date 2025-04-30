import 'dart:convert';

import 'package:flutter_recruitment_task/movies/list/domain/models/movie_list_item.dart';
import 'package:flutter_recruitment_task/movies/list/data/models/movie_list.dart';
import 'package:http/http.dart' as http;

class MovieListRemoteService {
  // TODO: move to dart define
  static const apiKey = '052afdb6e0ab9af424e3f3c8edbb33fb';
  // TODO: move to dart define
  static const baseUrl = 'api.themoviedb.org';

  Future<List<MovieListItem>> searchMovies({required String query}) async {
    final parameters = {
      'api_key': apiKey,
      'query': query,
    };

    final endpoint = Uri.https(baseUrl, '/3/search/movie', parameters);

    final response = await http.get(endpoint);
    final json = jsonDecode(response.body);
    final movieList = MovieList.fromJson(json);

    return movieList.results;
  }
}
