import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_avilatek_app/domain/entities/movie.dart';
import 'package:shadow_overlay/shadow_overlay.dart';

class CastedOnMasonryHorizontal extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  const CastedOnMasonryHorizontal({
    super.key,
    required this.movies,
    this.loadNextPage,
  });

  @override
  State<CastedOnMasonryHorizontal> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<CastedOnMasonryHorizontal> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.movies.length,
      itemBuilder: (context, index) {
        final movie = widget.movies[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _MoviePosterMasonry(movie: movie)),
        );
      },
    );
  }
}

class _MoviePosterMasonry extends StatelessWidget {
  final Movie movie;
  const _MoviePosterMasonry({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          //get movie id, this in configured on the router for pass the parameters
          onTap: () => context.push('/movie/${movie.id}'),
          child: _PosterInfo(movie: movie),
        ),
      ),
    );
  }
}

class _PosterInfo extends StatelessWidget {
  const _PosterInfo({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ShadowOverlay(
          shadowColor: Colors.black,
          shadowHeight: 120,
          shadowWidth: 160,
          child: Image.network(movie.posterPath)),
      Positioned(
        bottom: 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 11, bottom: 9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 150,
                ),
                child: Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                '${(movie.voteAverage * 100 / 10).round().toString()}% User Score',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
