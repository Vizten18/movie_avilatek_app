import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_avilatek_app/domain/entities/movie.dart';
import 'package:movie_avilatek_app/presentation/providers/movies/movies_repository_provider.dart';

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  //this watch the inmutable repository
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;

  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

//callback function that takes the json response page and return a future of List of movies
typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    //increment the page to bring new data
    currentPage++;
    //get the movies from the current page
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    //update the state
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
