import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_avilatek_app/domain/entities/movie.dart';
import 'package:movie_avilatek_app/presentation/widgets/widgets.dart';
import 'package:shadow_overlay/shadow_overlay.dart';

class MovieMasonry extends StatefulWidget {
  final int crossAcountLandscape;
  final int crossAcountVertical;
  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  const MovieMasonry({
    super.key,
    required this.movies,
    this.loadNextPage,
    required this.crossAcountLandscape,
    required this.crossAcountVertical,
  });

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {
  final scrollController = ScrollController();

  get crossAcountLandscape => widget.crossAcountLandscape;
  get crossAcountVertical => widget.crossAcountVertical;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if ((scrollController.position.pixels + 100) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: orientation == Orientation.landscape ? 50 : 26,
        ),
        child: MasonryGridView.count(
          controller: scrollController,
          crossAxisCount: orientation == Orientation.landscape
              ? crossAcountLandscape
              : crossAcountVertical,
          mainAxisSpacing: 26,
          crossAxisSpacing: 26,
          shrinkWrap: true,
          itemCount: widget.movies.length,
          itemBuilder: (context, index) {
            if (index == widget.movies.length - 1 && widget.movies.isEmpty) {
              return Column(
                children: [
                  const SizedBox(height: 40),
                  _MoviePosterMasonry(movie: widget.movies[index])
                ],
              );
            }

            return Transform.translate(
                offset: Offset(0.0, index.isOdd ? 50.0 : 0.0),
                child: _MoviePosterMasonry(movie: widget.movies[index]));
          },
        ),
      ),
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
          child: PosterInfo(movie: movie),
        ),
      ),
    );
  }
}

class PosterInfo extends StatelessWidget {
  const PosterInfo({
    super.key,
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
        child: CachedImageWidget(
          moviePoster: movie.posterPath,
          movieId: movie.id.toString(),
        ),
      ),
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
                    fontFamily: 'BalooBold',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                '${(movie.voteAverage * 100 / 10).round().toString()}% User Score',
                style: const TextStyle(
                  fontFamily: 'Baloo2Regular',
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
