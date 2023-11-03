import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_avilatek_app/presentation/providers/movies/casted_on_provider.dart';

final castedLoadingProvider = Provider((ref) {
  final step1 = ref.watch(castedOnProvider).isEmpty;

  if (step1) return true;

  return false; //end of load
});
