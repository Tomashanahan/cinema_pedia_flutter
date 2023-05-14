import 'package:cinema_pedia_flutter/config/constants/enviroment.dart';
import 'package:cinema_pedia_flutter/domain/datasources/movies_datasouces.dart';
import 'package:cinema_pedia_flutter/domain/entities/movie.dart';
import 'package:cinema_pedia_flutter/infrastructure/mappers/moviedb_mapper.dart';
import 'package:cinema_pedia_flutter/infrastructure/models/movie_db/moviedb_now_playing_response.dart';
import 'package:dio/dio.dart';

class MovieDbDataSource extends MoviesDatasource {
  final dio = Dio(
    BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
      "api_key": Environment.movieDbKey,
      "language": "es-MX"
    }),
  );

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');
    final movieDbResponse = MovieDbNowPlayingResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results
        .where((movieDb) => movieDb.posterPath != '')
        .map((movieDb) => MovieMapper.movieDbToEntity(movieDb))
        .toList();

    return movies;
  }
}
