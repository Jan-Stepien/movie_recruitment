import 'package:json_annotation/json_annotation.dart';

part 'movie_list_item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieListItem {
  final String title;
  final double voteAverage;
  final int id;

  MovieListItem({
    required this.title,
    required this.voteAverage,
    required this.id,
  });

  factory MovieListItem.fromJson(Map<String, dynamic> json) =>
      _$MovieListItemFromJson(json);

  Map<String, dynamic> toJson() => _$MovieListItemToJson(this);
}
