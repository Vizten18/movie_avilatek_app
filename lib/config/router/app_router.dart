import 'package:go_router/go_router.dart';
import 'package:movie_avilatek_app/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/config',
      builder: (context, state) => const SettingScreen(),
    ),
    GoRoute(
      path: '/movie/:id',
      name: MovieDetail.name,
      builder: (context, state) {
        final movieId = state.pathParameters['id'] ?? 'no-id';

        return MovieDetail(movieId: movieId);
      },
    ),
    GoRoute(
      path: '/actor/:id',
      name: ActorsScreen.name,
      builder: (context, state) {
        final actorId = state.pathParameters['id'] ?? 'no-id';

        return ActorsScreen(actorId: actorId);
      },
    ),
  ],
);
