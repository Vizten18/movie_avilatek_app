import 'package:flutter/material.dart';

class ScreenLoader extends StatelessWidget {
  const ScreenLoader({super.key});

  //instance created for the first load of the app
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 4,
              color: colors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
