import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_avilatek_app/domain/entities/movie.dart';
import 'package:movie_avilatek_app/presentation/providers/movies/movies_repository_provider.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  //this watch the inmutable repository
  final movieRepository = ref.watch(movieRepositoryProvider);
  return MovieMapNotifier(getMovie: movieRepository.getMovieById);
});

//callback function that takes the movie id and return a future of Movie
typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;

  MovieMapNotifier({
    required this.getMovie,
  }) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    //get the movie id
    final movie = await getMovie(movieId);
    //update the state
    state = {...state, movieId: movie};
  }
}
