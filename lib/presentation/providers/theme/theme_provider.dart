import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_avilatek_app/config/theme/app_theme.dart';

final isDarkMode = StateProvider((ref) => false);

final themeNotifierProvider = StateNotifierProvider<ThemeNofitifer, AppTheme>(
  (ref) => ThemeNofitifer(),
);

class ThemeNofitifer extends StateNotifier<AppTheme> {
  ThemeNofitifer() : super(AppTheme());

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }
}
