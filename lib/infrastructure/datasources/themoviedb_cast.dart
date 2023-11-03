import 'package:dio/dio.dart';
import 'package:movie_avilatek_app/config/constants/environment.dart';
import 'package:movie_avilatek_app/domain/datasources/cast_datasource.dart';
import 'package:movie_avilatek_app/domain/entities/actor.dart';
import 'package:movie_avilatek_app/domain/entities/actor_info.dart';
import 'package:movie_avilatek_app/infrastructure/mappers/cast_mapper.dart';
import 'package:movie_avilatek_app/infrastructure/models/moviedb/cast_detail.dart';
import 'package:movie_avilatek_app/infrastructure/models/moviedb/credits_response.dart';

class TheMoviedbCastDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      //env => environment api key
      'api_key': Environment.theMovieDbKey,
    },
  ));
  @override
  Future<List<Actor>> getActorByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    final castResponse = CreditsResponse.fromJson(response.data);
    List<Actor> actors =
        castResponse.cast.map((cast) => CastMapper.castToEntity(cast)).toList();

    return actors;
  }

  @override
  Future<ActorInfo> getActorId(String actorId) async {
    final response = await dio.get('/person/$actorId');
    if (response.statusCode != 200) {
      throw Exception('Actorwith id: $actorId not found');
    }

    final actorInfo = CastDetails.fromJson(response.data);
    final ActorInfo actor = CastMapper.actorDetailsToEntity(actorInfo);
    return actor;
  }
}
