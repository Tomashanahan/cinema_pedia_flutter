import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String movieDbKey = dotenv.env['MOVIE_DB_KEY'] ?? 'Noy hay API_KEY';
}
