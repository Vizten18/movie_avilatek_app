import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_avilatek_app/presentation/providers/providers.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final darkMode = ref.watch(themeNotifierProvider).isDarkMode;
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: darkMode
              ? const Icon(Icons.dark_mode_outlined)
              : const Icon(Icons.light_mode_outlined),
          onPressed: () {
            ref.read(isDarkMode.notifier).update((state) => !state);
            ref.read(themeNotifierProvider.notifier).toggleDarkMode();
          },
        ),
      ),
    );
  }
}
