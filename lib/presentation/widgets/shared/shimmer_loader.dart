import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(colors: [Colors.grey[300]!, Colors.grey[100]!]),
      child: const Card(
        color: Colors.white10,
        child: SizedBox(
          width: 151,
          height: 218,
        ),
      ),
    );
  }
}
