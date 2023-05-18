import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinema_pedia_flutter/domain/entities/movie.dart';
import 'package:cinema_pedia_flutter/presentation/providers/movies/search_movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String movieId);

class SearchMovieDelegate extends SearchDelegate {
  final SearchMoviesCallback getMovies;
  StreamController<List<Movie>> debounceMovieSearch =
      StreamController.broadcast();
  Timer? debounceTimer;
  List<Movie> initialMovies = [];

  SearchMovieDelegate({required this.getMovies}) : super();

  void _clearStreams() {
    debounceMovieSearch.close();
  }

  _onQueryChange(String query) {
    if (debounceTimer?.isActive ?? false) debounceTimer!.cancel();

    debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        debounceMovieSearch.add([]);
        return;
      }

      final movies = await getMovies(query);
      initialMovies = movies;
      debounceMovieSearch.add(movies);
    });
  }

  @override
  String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
            onPressed: () => query = '', icon: const Icon(Icons.close_rounded)),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          _clearStreams();
          context.pop();
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChange(query);
    return buildResultsAndSuggestions();
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debounceMovieSearch.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return _MovieCard(movie: movies[index]);
          },
        );
      },
    );
  }
}

class _MovieCard extends StatelessWidget {
  final Movie movie;
  const _MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/movie-detail/${movie.id}'),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                movie.posterPath,
                height: 120,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold),
                  ),
                  movie.overview.length >= 100
                      ? Text("${movie.overview.substring(0, 90)}...")
                      : Text(movie.overview)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
