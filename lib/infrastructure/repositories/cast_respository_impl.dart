import 'package:movie_avilatek_app/domain/datasources/cast_datasource.dart';
import 'package:movie_avilatek_app/domain/entities/actor.dart';
import 'package:movie_avilatek_app/domain/entities/actor_info.dart';
import 'package:movie_avilatek_app/domain/repositories/cast_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorRepositoryImpl(this.datasource);

  @override
  Future<List<Actor>> getActorByMovie(String movieId) {
    return datasource.getActorByMovie(movieId);
  }

  @override
  Future<ActorInfo> getActorId(String actorId) {
    return datasource.getActorId(actorId);
  }
}
