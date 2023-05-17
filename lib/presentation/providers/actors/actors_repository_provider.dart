import 'package:cinema_pedia_flutter/infrastructure/datasources/actors_moviedb_datasource.dart';
import 'package:cinema_pedia_flutter/infrastructure/repositories/movie_actor_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieActorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImplementation(ActorsMovieDbDataSource());
});
