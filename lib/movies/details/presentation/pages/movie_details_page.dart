import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recruitment_task/movies/details/domain/repositories/movie_details_repository.dart';
import 'package:flutter_recruitment_task/movies/details/presentation/state/movie_details_bloc/movie_details_bloc.dart';
import 'package:flutter_recruitment_task/movies/details/presentation/widgets/movie_detail_item.dart';
import 'package:flutter_recruitment_task/shared/presentation/models/loading_status.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({super.key, required this.movieId});

  final int movieId;

  static const routePath = '/details';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailsBloc(
        movieId: movieId,
        movieDetailsRepository: context.read<MovieDetailsRepository>(),
      ),
      child: const MovieDetailsView(),
    );
  }
}

class MovieDetailsView extends StatelessWidget {
  const MovieDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final status =
        context.select((MovieDetailsBloc bloc) => bloc.state.loadingStatus);
    final details =
        context.select((MovieDetailsBloc bloc) => bloc.state.details);
    final shouldWatch =
        context.select((MovieDetailsBloc bloc) => bloc.state.shouldWatch);

    return Scaffold(
      appBar: AppBar(
        title: Text(details?.title ?? ''),
      ),
      body: switch (status) {
        LoadingStatus.loaded || LoadingStatus.loadingMore => ListView(
            children: [
              MovieDetailItem(
                label: 'Budget',
                value: '\$${details?.budget?.toString() ?? ''}',
              ),
              const Divider(),
              MovieDetailItem(
                label: 'Revenue',
                value: '\$${details?.revenue?.toString() ?? ''}',
              ),
              const Divider(),
              MovieDetailItem(
                label: 'Should I watch it today?',
                value: shouldWatch ? 'Yes!' : 'No!',
              ),
            ],
          ),
        LoadingStatus.loading =>
          const Center(child: CircularProgressIndicator()),
        LoadingStatus.error => Center(
            child: Text(
              context.select(
                (MovieDetailsBloc bloc) => bloc.state.error ?? 'Error',
              ),
            ),
          ),
        LoadingStatus.initial => const Center(
            child: Text(
              'Initial',
            ),
          ),
      },
    );
  }
}
