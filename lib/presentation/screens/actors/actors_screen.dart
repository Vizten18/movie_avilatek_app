import 'package:animate_do/animate_do.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_avilatek_app/domain/entities/actor_info.dart';
import 'package:movie_avilatek_app/presentation/providers/providers.dart';
import 'package:movie_avilatek_app/presentation/widgets/widgets.dart';

class ActorsScreen extends ConsumerStatefulWidget {
  static const name = "actor-screen";
  final String actorId;
  const ActorsScreen({
    super.key,
    required this.actorId,
  });

  @override
  ActorsScreenState createState() => ActorsScreenState();
}

class ActorsScreenState extends ConsumerState<ActorsScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(actorsInfoProvider.notifier).loadActor(widget.actorId);
    ref.read(castedOnProvider.notifier).loadMoviesByActor(widget.actorId);
  }

  @override
  Widget build(BuildContext context) {
    final ActorInfo? actor = ref.watch(actorsInfoProvider)[widget.actorId];
    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

    if (actor == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: colors.primary,
          ),
        ),
      );
    }
    return Material(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 1,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: orientation == Orientation.landscape ? 0 : 10,
                left: 30,
                bottom: orientation == Orientation.landscape ? 0 : 20,
              ),
              child: SizedBox(
                height: 50,
                width: 50,
                child: IconButtonWidget(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onPressed: () => context.pop(),
                ),
              ),
            ),
            _InfoFromActor(
              actor: actor,
              sizeHeight: size.height,
              sizeWidth: size.width,
            ),
          ],
        ),
      ),
    );
  }
}

//conditional for the vertical or horizontal view from the phone
class _InfoFromActor extends ConsumerWidget {
  final double sizeWidth;
  final double sizeHeight;
  final ActorInfo actor;

  const _InfoFromActor({
    required this.actor,
    required this.sizeHeight,
    required this.sizeWidth,
  });

  @override
  Widget build(BuildContext context, ref) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return orientation == Orientation.landscape
        ? HorizontalContainer(
            actor: actor,
            sizeWidth: sizeWidth,
            orientation: orientation,
            sizeHeight: sizeHeight,
          )
        : VerticalContainer(
            actor: actor,
            sizeWidth: sizeWidth,
            orientation: orientation,
            sizeHeight: sizeHeight,
          );
  }
}

class VerticalContainer extends StatelessWidget {
  const VerticalContainer({
    super.key,
    required this.actor,
    required this.sizeWidth,
    required this.orientation,
    required this.sizeHeight,
  });

  final ActorInfo actor;
  final double sizeWidth;
  final Orientation orientation;
  final double sizeHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 13),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    actor.profilePath,
                  ),
                  radius: 36,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      actor.name,
                      style: const TextStyle(
                        fontFamily: 'BalooBold',
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  FadeIn(
                    child: SizedBox(
                      width: sizeWidth / 1.8,
                      height: orientation == Orientation.landscape
                          ? sizeHeight / 1.7
                          : sizeHeight / 7.5,
                      child: ListView(children: [
                        ExpandableText(
                          actor.biography,
                          style: const TextStyle(
                            fontFamily: 'Baloo2Regular',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            height: 1.7,
                          ),
                          maxLines: 4,
                          expandText: 'See more',
                          collapseText: 'See less',
                          expandOnTextTap: true,
                        ),
                      ]),
                    ),
                  ),
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Casted on',
                style: TextStyle(
                  fontFamily: 'BalooBold',
                  fontSize: 36,
                  fontWeight: FontWeight.w400,
                ),
              ),
              _CastedOnMovies(actorId: actor.id.toString()),
            ],
          ),
        ],
      ),
    );
  }
}

class HorizontalContainer extends StatelessWidget {
  const HorizontalContainer({
    super.key,
    required this.actor,
    required this.sizeWidth,
    required this.orientation,
    required this.sizeHeight,
  });

  final ActorInfo actor;
  final double sizeWidth;
  final Orientation orientation;
  final double sizeHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Row(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 13),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    actor.profilePath,
                  ),
                  radius: 36,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Text(
                      actor.name,
                      style: const TextStyle(
                        fontFamily: 'BalooBold',
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  FadeIn(
                    child: SizedBox(
                      width: sizeWidth / 1.8,
                      height: orientation == Orientation.landscape
                          ? sizeHeight / 1.7
                          : sizeHeight / 5,
                      child: ListView(children: [
                        ExpandableText(
                          actor.biography,
                          style: const TextStyle(
                            fontFamily: 'Baloo2Regular',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            height: 1.7,
                          ),
                          maxLines: 4,
                          expandText: 'See more',
                          collapseText: 'See less',
                          expandOnTextTap: true,
                        ),
                      ]),
                    ),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: sizeWidth / 50),
            child: SizedBox(
              width: sizeWidth / 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Casted on',
                    style: TextStyle(
                      fontFamily: 'BalooBold',
                      fontSize: 36,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  _CastedOnMoviesHorizontal(actorId: actor.id.toString()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//casted movies for the vertical view
class _CastedOnMovies extends ConsumerWidget {
  final String actorId;

  const _CastedOnMovies({
    required this.actorId,
  });

  @override
  Widget build(BuildContext context, ref) {
    final castedOn = ref.watch(castedOnProvider);
    final size = MediaQuery.of(context).size;

    if (castedOn[actorId] == null) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }
    final movies = castedOn[actorId]!;
    return SizedBox(
        height: size.height / 1.6,
        width: size.width,
        child: MovieMasonry(
          movies: movies,
          crossAcountLandscape: 1,
          crossAcountVertical: 2,
        ));
  }
}

//casted movies for the horizontal view
class _CastedOnMoviesHorizontal extends ConsumerWidget {
  final String actorId;

  const _CastedOnMoviesHorizontal({
    required this.actorId,
  });

  @override
  Widget build(BuildContext context, ref) {
    final castedOn = ref.watch(castedOnProvider);
    final size = MediaQuery.of(context).size;

    if (castedOn[actorId] == null) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }
    final movies = castedOn[actorId]!;
    return SizedBox(
        height: size.height / 1.7,
        width: size.width,
        child: CastedOnMasonryHorizontal(movies: movies));
  }
}
