import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData.from(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    );
  }

  static final WidgetStateProperty<Color?> chipBackgroundColor =
      WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.blue.withAlpha(128);
        }
        if (states.contains(WidgetState.hovered)) {
          return Colors.blue.withAlpha(64);
        }
        return Colors.black12;
      });

  static ThemeData get darkTheme {
    return ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
    ).copyWith(
      chipTheme: ChipThemeData(
        shadowColor: Colors.lightBlue,
        color: chipBackgroundColor,
        side: BorderSide(color: Colors.blue.withAlpha(128)),
      ),
    );
  }
}
