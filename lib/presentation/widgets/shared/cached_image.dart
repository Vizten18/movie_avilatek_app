import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_avilatek_app/presentation/widgets/shared/shimmer_loader.dart';

class CachedImageWidget extends StatelessWidget {
  final String moviePoster;
  final String movieId;
  const CachedImageWidget(
      {super.key, required this.moviePoster, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: ValueKey(movieId),
      imageUrl: moviePoster,
      fit: BoxFit.cover,
      placeholder: (context, url) => const ShimmerLoader(),
      errorWidget: (context, url, error) => const Icon(Icons.error_outline),
      placeholderFadeInDuration: Duration.zero,
    );
  }
}
