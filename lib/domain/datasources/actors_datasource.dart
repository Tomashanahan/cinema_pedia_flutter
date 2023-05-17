import 'package:cinema_pedia_flutter/domain/entities/actor.dart';

abstract class ActorsDataSource {
  Future<List<Actor>> getActors(String movieId);
}
