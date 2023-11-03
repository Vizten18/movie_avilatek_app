import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_avilatek_app/infrastructure/datasources/moviedb_datasource.dart';
import 'package:movie_avilatek_app/infrastructure/repositories/movie_repository_impl.dart';

// This repository is immutable
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(datasource: MoviedbDatasource());
});
