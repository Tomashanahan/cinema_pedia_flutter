import 'package:cinema_pedia_flutter/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/movie-detail/:id',
      name: MovieDetailScreen.name,
      builder: (context, state) {
        final routeId = state.pathParameters['id'] ?? 'no-id';

        return MovieDetailScreen(movieID: routeId);
      },
    )
  ],
);
