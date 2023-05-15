import 'package:cinema_pedia_flutter/domain/entities/movie.dart';
import 'package:cinema_pedia_flutter/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) {
    final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

    return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
  },
);

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) {
    final fetchMorePopularMovies = ref.watch(movieRepositoryProvider).getPopular;

    return MoviesNotifier(fetchMoreMovies: fetchMorePopularMovies);
  },
);

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) {
    final fetchMorePopularMovies = ref.watch(movieRepositoryProvider).getTopRated;

    return MoviesNotifier(fetchMoreMovies: fetchMorePopularMovies);
  },
);

final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) {
    final fetchMorePopularMovies = ref.watch(movieRepositoryProvider).getUpcoming;

    return MoviesNotifier(fetchMoreMovies: fetchMorePopularMovies);
  },
);

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;

    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];

    isLoading = false;
  }
}
