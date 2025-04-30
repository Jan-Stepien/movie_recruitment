part of 'movie_details_bloc.dart';

class MovieDetailsState extends Equatable {
  final LoadingStatus loadingStatus;
  final MovieDetails? details;
  final String? error;

  const MovieDetailsState({
    required this.loadingStatus,
    required this.details,
    this.error,
  });

  bool get shouldWatch {
    if (DateTime.now().weekday != 7) {
      return false;
    }
    final revenue = details?.revenue;
    final budget = details?.budget;
    if (revenue == null || budget == null) {
      return false;
    }
    return revenue - budget > 1000000;
  }

  @override
  List<Object?> get props => [loadingStatus, details, error];

  MovieDetailsState copyWith({
    LoadingStatus? loadingStatus,
    MovieDetails? details,
    String? error,
  }) =>
      MovieDetailsState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        details: details ?? this.details,
        error: error ?? this.error,
      );
}
