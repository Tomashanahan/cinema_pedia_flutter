import 'package:cinema_pedia_flutter/config/constants/enviroment.dart';
import 'package:cinema_pedia_flutter/config/helpers/moviedb_dio_base_config.dart';
import 'package:cinema_pedia_flutter/domain/datasources/actors_datasource.dart';
import 'package:cinema_pedia_flutter/domain/entities/actor.dart';
import 'package:cinema_pedia_flutter/infrastructure/mappers/moviedb_credits_mapper.dart';
import 'package:cinema_pedia_flutter/infrastructure/models/movie_db/movie_credits_response.dart';
import 'package:dio/dio.dart';

class ActorsMovieDbDataSource extends ActorsDataSource {
  final Dio dio = DioMovieDb.dio();

  @override
  Future<List<Actor>> getActors(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    final castResponse = MovieCreditsResponse.fromJson(response.data);

    List<Actor> actor = castResponse.cast
        .map((actor) => MovieCreditsMapper.movieCastCreditsToEntity(actor))
        .toList();

    return actor;
  }
}
