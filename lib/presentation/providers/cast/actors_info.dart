import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_avilatek_app/domain/entities/actor_info.dart';
import 'package:movie_avilatek_app/presentation/providers/cast/cast_repository_provider.dart';

final actorsInfoProvider =
    StateNotifierProvider<ActorMapNotifier, Map<String, ActorInfo>>((ref) {
  //watch the inmutable repository
  final actorRepository = ref.watch(actorRepositoryProvider);
  return ActorMapNotifier(getActor: actorRepository.getActorId);
});

//callback function that takes an actor id and return a future of actor info
typedef GetActorCallBack = Future<ActorInfo> Function(String actorId);

class ActorMapNotifier extends StateNotifier<Map<String, ActorInfo>> {
  final GetActorCallBack getActor;

  ActorMapNotifier({
    required this.getActor,
  }) : super({});

  Future<void> loadActor(String actorId) async {
    if (state[actorId] != null) return;
    final actor = await getActor(actorId);
    //update the state with the new actor info
    state = {...state, actorId: actor};
  }
}
