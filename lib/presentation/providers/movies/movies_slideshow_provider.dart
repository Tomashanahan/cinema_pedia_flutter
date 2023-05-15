import 'package:cinema_pedia_flutter/domain/entities/movie.dart';
import 'package:cinema_pedia_flutter/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesSubListProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if (nowPlayingMovies.isEmpty) return [];

  return nowPlayingMovies.sublist(0, 6);
});
