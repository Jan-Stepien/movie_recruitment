import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recruitment_task/movies/details/domain/repositories/movie_details_repository.dart';
import 'package:flutter_recruitment_task/movies/details/domain/models/movie_details.dart';
import 'package:flutter_recruitment_task/shared/presentation/models/loading_status.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final int _movieId;
  final MovieDetailsRepository _movieDetailsRepository;

  final List<StreamSubscription> _subscriptions = [];

  MovieDetailsBloc({
    required int movieId,
    required MovieDetailsRepository movieDetailsRepository,
  })  : _movieId = movieId,
        _movieDetailsRepository = movieDetailsRepository,
        super(MovieDetailsState(
          loadingStatus: LoadingStatus.initial,
          details: null,
        )) {
    on<FetchMovieDetails>(_onFetchMovieDetails);
    on<DetailsChanged>(_onDetailsChanged);

    _subscriptions.add(_movieDetailsRepository.stream
        .where((details) => details?.id == _movieId)
        .listen((details) => add(DetailsChanged(details))));

    add(FetchMovieDetails(_movieId));
  }

  Future<void> _onFetchMovieDetails(
    FetchMovieDetails event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(state.copyWith(
      loadingStatus: LoadingStatus.loading,
    ));
    try {
      await _movieDetailsRepository.fetchMovieDetails(event.movieId);
    } catch (e) {
      if (state.details == null) {
        emit(state.copyWith(
          loadingStatus: LoadingStatus.error,
          error: e.toString(),
        ));
      }
    }
  }

  FutureOr<void> _onDetailsChanged(
    DetailsChanged event,
    Emitter<MovieDetailsState> emit,
  ) {
    emit(state.copyWith(
      loadingStatus: LoadingStatus.loaded,
      details: event.details,
    ));
  }

  @override
  Future<void> close() {
    for (var subscription in _subscriptions) {
      subscription.cancel();
    }
    return super.close();
  }
}
