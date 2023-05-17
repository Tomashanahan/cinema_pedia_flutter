import 'package:cinema_pedia_flutter/domain/entities/actor.dart';
import 'package:cinema_pedia_flutter/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieActorsProvider =
    StateNotifierProvider<MovieActorsNotifier, Map<String, List<Actor>>>(
  (ref) {
    final actorsRepository = ref.watch(movieActorsRepositoryProvider).getActors;

    return MovieActorsNotifier(getMovieActors: actorsRepository);
  },
);

typedef GetMovieActorsCallBack = Future<List<Actor>> Function(String movieId);

class MovieActorsNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetMovieActorsCallBack getMovieActors;

  MovieActorsNotifier({required this.getMovieActors}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final List<Actor> movieActors = await getMovieActors(movieId);

    state = {...state, movieId: movieActors};
  }
}
