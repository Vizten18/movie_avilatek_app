import 'package:movie_avilatek_app/domain/entities/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getPopular({int page = 1});

  Future<Movie> getMovieById(String id);

  Future<List<Movie>> getCastedOn(String actorId);
}
