import 'package:cinema_pedia_flutter/presentation/providers/providers.dart';
import 'package:cinema_pedia_flutter/presentation/widgets/shared/custom_bottom_navigation_bar_widget.dart';
import 'package:cinema_pedia_flutter/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'HomeScreen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final isInitialLoading = ref.watch(initialLoadingProvider);
    if (isInitialLoading) {
      return const FullScreenLoader();
    }

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    final moviesSubList = ref.watch(moviesSubListProvider);

    final nowPlayingMoviesLoadMoreMovies =
        ref.read(nowPlayingMoviesProvider.notifier).loadNextPage;
    final upcomingMoviesLoadMoreMovies =
        ref.read(upcomingMoviesProvider.notifier).loadNextPage;
    final popularMoviesLoadMoreMovies =
        ref.read(popularMoviesProvider.notifier).loadNextPage;
    final topRatedMoviesLoadMoreMovies =
        ref.read(topRatedMoviesProvider.notifier).loadNextPage;

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBarWidget(),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  MoviesSlideShowWidget(movies: moviesSubList),
                  MovieHorizontalListView(
                    movies: nowPlayingMovies,
                    title: 'En cines',
                    subTitle: 'Lunes 20',
                    loadNextPage: nowPlayingMoviesLoadMoreMovies,
                  ),
                  const SizedBox(height: 20),
                  MovieHorizontalListView(
                    movies: upcomingMovies,
                    title: 'Próximamente en cines',
                    subTitle: 'Lunes 20',
                    loadNextPage: upcomingMoviesLoadMoreMovies,
                  ),
                  const SizedBox(height: 20),
                  MovieHorizontalListView(
                    movies: popularMovies,
                    title: 'Populares',
                    loadNextPage: popularMoviesLoadMoreMovies,
                  ),
                  const SizedBox(height: 20),
                  MovieHorizontalListView(
                    movies: topRatedMovies,
                    title: 'Top Rated',
                    subTitle: 'De todos los tiempos',
                    loadNextPage: topRatedMoviesLoadMoreMovies,
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
            childCount: 1,
          ),
        )
      ],
    );
  }
}
