import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_avilatek_app/domain/entities/movie.dart';
import 'package:movie_avilatek_app/presentation/providers/movies/movies_repository_provider.dart';

final castedOnProvider =
    StateNotifierProvider<MoviesByActorNotifier, Map<String, List<Movie>>>(
  (ref) {
    //this watch the inmutable repository
    final movieRepository = ref.watch(movieRepositoryProvider);

    return MoviesByActorNotifier(getCastedOn: movieRepository.getCastedOn);
  },
);
//callback function that takes an actor id and return a future of list movies
typedef GetMoviesByActorCallback = Future<List<Movie>> Function(String actorId);

class MoviesByActorNotifier extends StateNotifier<Map<String, List<Movie>>> {
  final GetMoviesByActorCallback getCastedOn;

  MoviesByActorNotifier({
    required this.getCastedOn,
  }) : super({});

  Future<void> loadMoviesByActor(String actorId) async {
    if (state[actorId] != null) return;
    //get movies
    final List<Movie> movies = await getCastedOn(actorId);
    //update state
    state = {...state, actorId: movies};
  }
}
