import 'package:movie_avilatek_app/domain/datasources/movies_datasource.dart';
import 'package:movie_avilatek_app/domain/entities/movie.dart';
import 'package:movie_avilatek_app/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl implements MoviesRepository {
  final MovieDatasource datasource;

  MovieRepositoryImpl({required this.datasource});

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<Movie> getMovieById(String id) {
    return datasource.getMovieById(id);
  }

  @override
  Future<List<Movie>> getCastedOn(String actorId) {
    return datasource.getCastedOn(actorId);
  }
}
