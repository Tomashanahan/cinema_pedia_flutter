import 'package:cinema_pedia_flutter/presentation/delegates/search_movie_delegate.dart';
import 'package:cinema_pedia_flutter/presentation/providers/movies/search_movie_provider.dart';
import 'package:cinema_pedia_flutter/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBarWidget extends ConsumerWidget {
  const CustomAppBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeContext = Theme.of(context).colorScheme.primary;
    final titleThemeContext = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.movie_outlined,
                color: themeContext,
              ),
              const SizedBox(width: 5),
              Text('Cienemapedia', style: titleThemeContext),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    final movieProvider =
                        ref.read(movieRepositoryProvider).searchMovie;
                    showSearch(
                        query: ref.read(searchMovieProvider),
                        context: context,
                        delegate: SearchMovieDelegate(
                          getMovies: (query) {
                            ref.read(searchMovieProvider.notifier).state =
                                query;
                            return movieProvider(query);
                          },
                        ));
                  },
                  icon: const Icon(Icons.search_rounded))
            ],
          ),
        ),
      ),
    );
  }
}
