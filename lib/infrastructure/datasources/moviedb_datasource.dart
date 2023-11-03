import 'package:dio/dio.dart';
import 'package:movie_avilatek_app/config/constants/environment.dart';
import 'package:movie_avilatek_app/domain/datasources/movies_datasource.dart';
import 'package:movie_avilatek_app/domain/entities/movie.dart';
import 'package:movie_avilatek_app/infrastructure/mappers/movie_mapper.dart';
import 'package:movie_avilatek_app/infrastructure/models/moviedb/movie_details.dart';
import 'package:movie_avilatek_app/infrastructure/models/moviedb/movie_themoviedb.dart';
import 'package:movie_avilatek_app/infrastructure/models/moviedb/themoviedb_response.dart';

class MoviedbDatasource extends MovieDatasource {
  final dio = Dio(
    BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
      //env => environment api key
      'api_key': Environment.theMovieDbKey,
      'language': 'en-US'
    }),
  );

  //pass the json response to list of object movie
  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final moviedbResponse = MovieDbResponse.fromJson(json);
    final List<Movie> movies = moviedbResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    try {
      final response = await dio.get(
        '/movie/popular',
        queryParameters: {'page': page},
      );
      return _jsonToMovies(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Movie> getMovieById(String id) async {
    try {
      final response = await dio.get('/movie/$id');
      if (response.statusCode != 200) {
        throw Exception('Movie with id: $id not found');
      }
      final movieDetails = MovieDetails.fromJson(response.data);
      final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);
      return movie;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Movie>> getCastedOn(String actorId) async {
    try {
      final response = await dio.get('/person/$actorId/movie_credits');
      final jsonResponse = response.data;
      //Access to List<Cast> from Actor entities but its a Movie Object
      List<Movie> movies = (jsonResponse['cast'] as List<dynamic>)
          .map((movieJson) =>
              MovieMapper.movieDBToEntity(MovieMovieDB.fromJson(movieJson)))
          .toList();

      return movies;
    } catch (e) {
      rethrow;
    }
  }
}
