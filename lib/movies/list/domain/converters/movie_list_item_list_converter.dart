import 'package:flutter_recruitment_task/movies/list/domain/models/movie_list_item.dart';
import 'package:json_annotation/json_annotation.dart';

class MovieListItemListConverter
    implements JsonConverter<List<MovieListItem>, List<Map<String, dynamic>>> {
  const MovieListItemListConverter();

  @override
  List<Map<String, dynamic>> toJson(List<MovieListItem> blocks) {
    return blocks.map((b) => b.toJson()).toList();
  }

  @override
  List<MovieListItem> fromJson(List jsonString) {
    return jsonString
        .map((dynamic e) => MovieListItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
