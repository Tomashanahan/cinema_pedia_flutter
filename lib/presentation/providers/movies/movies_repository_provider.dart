import 'package:cinema_pedia_flutter/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinema_pedia_flutter/infrastructure/repositories/movie_repository_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRepositoryProvider = Provider(
  (ref) {
    return MovieRepositoryImplementation(MovieDbDataSource());
  },
);