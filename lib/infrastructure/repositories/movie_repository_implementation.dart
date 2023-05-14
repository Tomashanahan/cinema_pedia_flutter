import 'package:cinema_pedia_flutter/domain/datasources/movies_datasouces.dart';
import 'package:cinema_pedia_flutter/domain/entities/movie.dart';
import 'package:cinema_pedia_flutter/domain/repositories/movies_repository.dart';

class MovieRepositoryImplementation extends MoviesRepository {
  final MoviesDatasource dataSource;

  MovieRepositoryImplementation(this.dataSource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return dataSource.getNowPlaying(page: page);
  }
}
