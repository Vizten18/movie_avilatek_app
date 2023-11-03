import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_avilatek_app/presentation/providers/movies/movies_provider.dart';

final initialLoadingProvider = Provider((ref) {
  //if you have another endpoint like upcoming movies, top rated, etc, you must be add the steps for anyone
  final step1 = ref.watch(popularMoviesProvider).isEmpty;

  //with more endpoints providers this need to be write like if(step1 || step2 || ...)
  if (step1) return true;

  return false; //end of load
});
