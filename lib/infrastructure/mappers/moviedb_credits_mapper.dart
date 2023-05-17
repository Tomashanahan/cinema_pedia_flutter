import 'package:cinema_pedia_flutter/domain/entities/actor.dart';
import 'package:cinema_pedia_flutter/infrastructure/models/movie_db/movie_credits_response.dart';

class MovieCreditsMapper {
  static Actor movieCastCreditsToEntity(Cast movieCast) {
    return Actor(
      id: movieCast.id,
      name: movieCast.name,
      profilePath: movieCast.profilePath != null
          ? 'https://image.tmdb.org/t/p/w500${movieCast.profilePath}'
          : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
      character: movieCast.character,
    );
  }
}
