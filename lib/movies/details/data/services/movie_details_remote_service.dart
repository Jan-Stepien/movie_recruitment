import 'dart:convert';

import 'package:flutter_recruitment_task/movies/details/domain/models/movie_details.dart';
import 'package:http/http.dart' as http;

class MovieDetailsRemoteService {
  final String _apiKey;
  final String _baseUrl;

  MovieDetailsRemoteService({
    required String apiKey,
    required String baseUrl,
  })  : _apiKey = apiKey,
        _baseUrl = baseUrl;

  Future<MovieDetails> fetchMovieDetails(int movieId) async {
    final parameters = {
      'api_key': _apiKey,
    };

    final endpoint = Uri.https(_baseUrl, '/3/movie/$movieId', parameters);

    final response = await http.get(endpoint);
    final json = jsonDecode(response.body);

    return MovieDetails.fromJson(json);
  }
}
