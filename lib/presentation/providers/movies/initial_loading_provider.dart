import 'package:cinema_pedia_flutter/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingProvider = Provider<bool>(
  (ref) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider).isEmpty;
    final upcomingMovies = ref.watch(upcomingMoviesProvider).isEmpty;
    final popularMovies = ref.watch(popularMoviesProvider).isEmpty;
    final topRatedMovies = ref.watch(topRatedMoviesProvider).isEmpty;

    if (nowPlayingMovies || upcomingMovies || popularMovies || topRatedMovies) {
      return true;
    }

    return false;
  },
);
