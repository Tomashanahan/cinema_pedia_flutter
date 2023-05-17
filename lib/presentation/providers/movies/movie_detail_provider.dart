import 'package:cinema_pedia_flutter/domain/entities/movie.dart';
import 'package:cinema_pedia_flutter/domain/repositories/movies_repository.dart';
import 'package:cinema_pedia_flutter/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieDetailProvider =
    StateNotifierProvider<MovieDetailNotifier, Map<String, Movie>>((ref) {
  final moviesRepository = ref.watch(movieRepositoryProvider).getMovieDetail;

  return MovieDetailNotifier(getMovie: moviesRepository);
});

typedef GetMovieCallBack = Future<Movie> Function({required String id});

class MovieDetailNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallBack getMovie;

  MovieDetailNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return; 

    print('realizando la petición http');
    final movieDetail = await getMovie(id: movieId);

    state = {...state, movieId: movieDetail};
  }
}
