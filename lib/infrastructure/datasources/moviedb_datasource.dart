import 'package:cinema_pedia_flutter/config/constants/enviroment.dart';
import 'package:cinema_pedia_flutter/config/helpers/moviedb_dio_base_config.dart';
import 'package:cinema_pedia_flutter/domain/datasources/movies_datasouces.dart';
import 'package:cinema_pedia_flutter/domain/entities/movie.dart';
import 'package:cinema_pedia_flutter/infrastructure/mappers/moviedb_mapper.dart';
import 'package:cinema_pedia_flutter/infrastructure/models/movie_db/movie_detail_response.dart';
import 'package:cinema_pedia_flutter/infrastructure/models/movie_db/moviedb_now_playing_response.dart';
import 'package:dio/dio.dart';

class MovieDbDataSource extends MoviesDatasource {
  final dio = DioMovieDb.dio();

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = _formJson(url: '/movie/now_playing', page: page);

    return response;
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = _formJson(url: '/movie/popular', page: page);

    return response;
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    final response = _formJson(url: '/movie/top_rated', page: page);

    return response;
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    final response = _formJson(url: '/movie/upcoming', page: page);

    return response;
  }

  @override
  Future<Movie> getMovieDetail({required String id}) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200)
      throw Exception('Movie with id: $id not found');
    final movieDbResponse = MovieDetailResponse.fromJson(response.data);

    final Movie movie = MovieMapper.movieDetailToEntity(movieDbResponse);

    return movie;
  }

  Future<List<Movie>> _formJson(
      {required String url, required int page}) async {
    final response = await dio.get(url, queryParameters: {"page": page});
    final movieDbResponse = MovieDbNowPlayingResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results
        .where((movieDb) => movieDb.posterPath != '')
        .map((movieDb) => MovieMapper.movieDbToEntity(movieDb))
        .toList();

    return movies;
  }
}
