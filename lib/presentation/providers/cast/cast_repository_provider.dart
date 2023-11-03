// This repository is immutable
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_avilatek_app/infrastructure/datasources/themoviedb_cast.dart';
import 'package:movie_avilatek_app/infrastructure/repositories/cast_respository_impl.dart';

//this repository is immutable
final actorRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(TheMoviedbCastDatasource());
});
