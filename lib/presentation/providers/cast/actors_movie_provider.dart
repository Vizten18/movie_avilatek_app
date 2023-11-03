import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_avilatek_app/domain/entities/actor.dart';
import 'package:movie_avilatek_app/presentation/providers/cast/cast_repository_provider.dart';

final actorByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(
  (ref) {
    //watch the inmutable repository
    final actorsRepository = ref.watch(actorRepositoryProvider);

    return ActorsByMovieNotifier(getActors: actorsRepository.getActorByMovie);
  },
);

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsByMovieNotifier({
    required this.getActors,
  }) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;
    //get the list of actors
    final List<Actor> actors = await getActors(movieId);
    //update the state
    state = {...state, movieId: actors};
  }
}
