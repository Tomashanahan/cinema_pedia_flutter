import 'package:cinema_pedia_flutter/config/constants/enviroment.dart';
import 'package:dio/dio.dart';

class DioMovieDb {
  static Dio dio() {
    final Dio dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
        "api_key": Environment.movieDbKey,
        "language": "es-MX"
      }),
    );
    return dio;
  }
}
