import 'package:flutter_dotenv/flutter_dotenv.dart';

//environment api key for themoviedb, you can change it from the env file
class Environment {
  static String theMovieDbKey =
      dotenv.env['THE_MOVIEDB_KEY'] ?? 'No hay api key';
}
