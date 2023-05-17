import 'package:cinema_pedia_flutter/domain/datasources/actors_datasource.dart';
import 'package:cinema_pedia_flutter/domain/entities/actor.dart';
import 'package:cinema_pedia_flutter/domain/repositories/actors_repository.dart';
import 'package:cinema_pedia_flutter/infrastructure/datasources/actors_moviedb_datasource.dart';

class ActorRepositoryImplementation extends ActorsRepository {
  final ActorsDataSource dataSource;

  ActorRepositoryImplementation(this.dataSource);

  @override
  Future<List<Actor>> getActors(String movieId) {
    return dataSource.getActors(movieId);
  }
}
