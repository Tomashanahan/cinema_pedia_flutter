import 'package:cinema_pedia_flutter/presentation/screens/screens.dart';
import 'package:cinema_pedia_flutter/presentation/views/home_views/favorites_view.dart';
import 'package:cinema_pedia_flutter/presentation/views/home_views/home_view.dart';
import 'package:cinema_pedia_flutter/presentation/views/views.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return HomeScreen(childView: child);
      },
      routes: <RouteBase>[
        GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return const HomeView();
            },
            routes: [
              GoRoute(
                path: 'movie-detail/:id',
                name: MovieDetailScreen.name,
                builder: (context, state) {
                  final routeId = state.pathParameters['id'] ?? 'no-id';

                  return MovieDetailScreen(movieID: routeId);
                },
              )
            ]),
        GoRoute(
          path: '/favorites',
          builder: (BuildContext context, GoRouterState state) {
            return const FavoritesView();
          },
        ),
        GoRoute(
          path: '/categories',
          builder: (BuildContext context, GoRouterState state) {
            return const CategoryView();
          },
        ),
      ],
    ),
  ],
);
