import 'package:animate_do/animate_do.dart';
import 'package:cinema_pedia_flutter/config/helpers/format_number_helper.dart';
import 'package:cinema_pedia_flutter/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListView extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListView({
    super.key,
    required this.movies,
    this.title,
    this.subTitle,
    this.loadNextPage,
  });

  @override
  State<MovieHorizontalListView> createState() =>
      _MovieHorizontalListViewState();
}

class _MovieHorizontalListViewState extends State<MovieHorizontalListView> {
  final listViewController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.loadNextPage == null) return;

    listViewController.addListener(() {
      final listViewPosition = listViewController.position;
      if ((listViewPosition.pixels + 100) >= listViewPosition.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    listViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 370,
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
            _Title(title: widget.title, subTitle: widget.subTitle),
          Expanded(
            child: ListView.builder(
              controller: listViewController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FadeInRight(child: _Slide(movie: widget.movies[index]));
              },
            ),
          )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // * Movie Image
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                movie.posterPath,
                width: 150,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Center(
                      heightFactor: 5,
                      child: CircularProgressIndicator(),
                    );
                  }

                  return FadeIn(child: child);
                },
              ),
            ),
          ),

          // * Spacer
          const SizedBox(height: 5),

          // * Title
          SizedBox(
            width: 150,
            child: Text(movie.title, maxLines: 2, style: textStyle.titleSmall),
          ),

          // * Spacer
          const SizedBox(height: 5),

          // * Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.star_half_rounded, color: Colors.amber),
              Text(
                movie.voteAverage.toString(),
                style: textStyle.titleMedium
                    ?.copyWith(color: Colors.yellow.shade800),
              ),
              const SizedBox(width: 15),
              Text(
                FormatNumber.number(movie.popularity),
                style: textStyle.bodySmall,
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _Title({
    this.title,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (title != null) Text("$title", style: titleStyle),
          if (subTitle != null)
            FilledButton.tonal(onPressed: () {}, child: Text("$subTitle")),
        ],
      ),
    );
  }
}
