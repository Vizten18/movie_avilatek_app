import 'package:movie_avilatek_app/domain/entities/actor.dart';
import 'package:movie_avilatek_app/domain/entities/actor_info.dart';

abstract class ActorsRepository {
  Future<List<Actor>> getActorByMovie(String movieId);
  Future<ActorInfo> getActorId(String actorId);
}
