import 'package:flutter/material.dart';

const colorList = <Color>[
  Color(0XFF00eb98),
  Color(0XFF00acec),
];

class AppTheme {
  final bool isDarkMode;
  AppTheme({
    this.isDarkMode = false,
  });
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0XFF00eb98),
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      );

  AppTheme copyWith({bool? isDarkMode}) => AppTheme(
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );
}
