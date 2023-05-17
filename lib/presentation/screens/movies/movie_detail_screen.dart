import 'package:cinema_pedia_flutter/domain/entities/actor.dart';
import 'package:cinema_pedia_flutter/domain/entities/movie.dart';
import 'package:cinema_pedia_flutter/presentation/providers/movies/movie_detail_provider.dart';
import 'package:cinema_pedia_flutter/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieDetailScreen extends ConsumerStatefulWidget {
  static const name = 'MovieDetailScreen';
  final String movieID;

  const MovieDetailScreen({super.key, required this.movieID});

  @override
  MovieDetailScreenState createState() => MovieDetailScreenState();
}

class MovieDetailScreenState extends ConsumerState<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieDetailProvider.notifier).loadMovie(widget.movieID);
    ref.read(movieActorsProvider.notifier).loadActors(widget.movieID);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movieDetail = ref.watch(movieDetailProvider)[widget.movieID];

    if (movieDetail == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverWidget(
            movie: movieDetail,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) {
              return _MovieDetails(
                movie: movieDetail,
                actors: [],
              );
            },
          ))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  final List<Actor> actors;
  const _MovieDetails({
    required this.movie,
    required this.actors,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.originalTitle, style: textTheme.titleLarge),
                  const SizedBox(height: 10),
                  Text(movie.overview, style: textTheme.bodyMedium),
                  const SizedBox(height: 30),
                  // * Categorías
                  // Chip(label: movie.genreIds)
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movie.genreIds.length,
                      itemBuilder: (context, index) {
                        final genre = movie.genreIds[index];
                        return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            child: Chip(label: Text(genre)));
                      },
                    ),
                  ),

                  //* Actores
                  _MovieActors(
                    movieId: movie.id.toString(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MovieActors extends ConsumerWidget {
  final String movieId;

  const _MovieActors({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieActors = ref.watch(movieActorsProvider)[movieId];

    return movieActors != null
        ? SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movieActors.length,
              itemBuilder: (context, index) {
                final actor = movieActors[index];
                return Container(
                  width: 140,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          actor.profilePath,
                          width: 135,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        actor.name,
                        maxLines: 1,
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                      const SizedBox(height: 10),
                      Text(actor.character ?? '',
                          maxLines: 2,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          )),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ),
          )
        : const SizedBox();
  }
}

class _CustomSliverWidget extends StatelessWidget {
  final Movie movie;

  const _CustomSliverWidget({required this.movie});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: screenSize.height * 0.7,
      foregroundColor:
          Colors.white, //* esto cambia de color la flecha para volver
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(movie.posterPath, fit: BoxFit.cover),
            ),
            const SizedBox.expand(
                child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                  stops: [0.7, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            )),
            const SizedBox.expand(
                child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.3],
                  begin: Alignment.topLeft,
                ),
              ),
            )),
          ],
        ),
        titlePadding: const EdgeInsets.all(10),
      ),
    );
  }
}
