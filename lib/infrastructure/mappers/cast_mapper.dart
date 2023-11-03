import 'package:movie_avilatek_app/domain/entities/actor.dart';
import 'package:movie_avilatek_app/domain/entities/actor_info.dart';
import 'package:movie_avilatek_app/infrastructure/models/moviedb/cast_detail.dart';
import 'package:movie_avilatek_app/infrastructure/models/moviedb/credits_response.dart';

class CastMapper {
  static Actor castToEntity(Cast cast) => Actor(
        id: cast.id,
        name: cast.name,
        profilePath: cast.profilePath != null
            ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
            : 'https://t4.ftcdn.net/jpg/05/09/59/75/240_F_509597532_RKUuYsERhODmkxkZd82pSHnFtDAtgbzJ.jpg',
        character: cast.character,
      );

  static ActorInfo actorDetailsToEntity(CastDetails actorInfo) => ActorInfo(
        id: actorInfo.id,
        name: actorInfo.name,
        profilePath: actorInfo.profilePath != null
            ? 'https://image.tmdb.org/t/p/w500${actorInfo.profilePath}'
            : 'https://t4.ftcdn.net/jpg/05/09/59/75/240_F_509597532_RKUuYsERhODmkxkZd82pSHnFtDAtgbzJ.jpg',
        biography: actorInfo.biography,
      );
}
