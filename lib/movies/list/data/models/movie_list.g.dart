// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieList _$MovieListFromJson(Map<String, dynamic> json) => MovieList(
      totalResults: (json['total_results'] as num).toInt(),
      results: const MovieListItemListConverter()
          .fromJson(json['results'] as List<Map<String, dynamic>>),
    );

Map<String, dynamic> _$MovieListToJson(MovieList instance) => <String, dynamic>{
      'total_results': instance.totalResults,
      'results': const MovieListItemListConverter().toJson(instance.results),
    };
