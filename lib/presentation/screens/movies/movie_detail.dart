import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_avilatek_app/domain/entities/actor.dart';
import 'package:movie_avilatek_app/domain/entities/movie.dart';
import 'package:movie_avilatek_app/presentation/widgets/widgets.dart';
import 'package:shadow_overlay/shadow_overlay.dart';
import 'package:movie_avilatek_app/presentation/providers/providers.dart';

class MovieDetail extends ConsumerStatefulWidget {
  static const name = "movie-screen";
  final String movieId;
  const MovieDetail({
    super.key,
    required this.movieId,
  });

  @override
  MovieDetailState createState() => MovieDetailState();
}

class MovieDetailState extends ConsumerState<MovieDetail> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];
    final colors = Theme.of(context).colorScheme;

    if (movie == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: colors.primary,
          ),
        ),
      );
    }
    return Scaffold(
      body: _InfoFromTheMovie(movie: movie),
    );
  }
}

class _InfoFromTheMovie extends StatefulWidget {
  final Movie movie;
  const _InfoFromTheMovie({
    required this.movie,
  });

  @override
  State<_InfoFromTheMovie> createState() => _InfoFromTheMovieState();
}

class _InfoFromTheMovieState extends State<_InfoFromTheMovie> {
  bool showInfo = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        setState(() {
          showInfo = true;
        });
      },
      child: Stack(
        children: [
          _MovieInfoPoster(size: size, widget: widget),
          Positioned(
            top: 0,
            left: 0,
            child: Padding(
                padding: const EdgeInsets.only(top: 70, left: 20),
                child: IconButtonWidget(
                  icon: Icons.close,
                  onPressed: () => context.pop(),
                )),
          ),
          Visibility(
            visible: showInfo,
            child: Positioned(
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInLeft(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width / 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.movie.title,
                            style: const TextStyle(
                              fontFamily: 'BalooBold',
                              color: Colors.white,
                              fontSize: 42,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${(widget.movie.voteAverage * 100 / 10).round().toString()}% User Score',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Baloo2Regular',
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _Actors(
                    movieId: widget.movie.id.toString(),
                    sizeWidth: size.width,
                    sizeHeight: size.height,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieInfoPoster extends StatelessWidget {
  const _MovieInfoPoster({
    required this.size,
    required this.widget,
  });

  final Size size;
  final _InfoFromTheMovie widget;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return ShadowOverlay(
      shadowHeight: orientation == Orientation.landscape
          ? size.height / 1
          : size.height / 2.3,
      shadowWidth: size.width,
      shadowColor: Colors.black,
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: CachedNetworkImage(
          imageUrl: orientation == Orientation.landscape
              ? widget.movie.backdropPath
              : widget.movie.posterPath,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}

class _Actors extends ConsumerWidget {
  final double sizeWidth;
  final double sizeHeight;
  final String movieId;
  const _Actors(
      {required this.movieId,
      required this.sizeWidth,
      required this.sizeHeight});

  @override
  Widget build(BuildContext context, ref) {
    Orientation orientation = MediaQuery.of(context).orientation;
    final actorsByMovie = ref.watch(actorByMovieProvider);
    if (actorsByMovie[movieId] == null) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }
    final actors = actorsByMovie[movieId]!;
    return SizedBox(
      height: orientation == Orientation.landscape
          ? sizeHeight / 1.8
          : sizeHeight / 4,
      width: sizeWidth,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];
          return GestureDetector(
            //send parameters(actor.id) to ActorScreen
            onTap: () => context.push('/actor/${actor.id}'),
            child: _ActorInfo(actor: actor),
          );
        },
      ),
    );
  }
}

class _ActorInfo extends StatelessWidget {
  const _ActorInfo({
    required this.actor,
  });

  final Actor actor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 0, left: 23, top: 21, bottom: 23),
      child: Stack(
        children: [
          ShadowOverlay(
            shadowColor: Colors.black87,
            shadowHeight: 120,
            shadowWidth: 160,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 120,
                height: 200,
                child: FadeIn(
                  child: CachedImageWidget(
                      moviePoster: actor.profilePath,
                      movieId: actor.id.toString()),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 8),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      actor.name,
                      style: const TextStyle(
                        fontFamily: 'BalooBold',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      actor.character!,
                      style: const TextStyle(
                        fontFamily: 'Baloo2Regular',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
