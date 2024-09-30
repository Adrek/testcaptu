// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

part 'variables/colorize.dart';
part 'variables/content.dart';
part 'variables/corner_radius.dart';
part 'variables/spacing.dart';

const kEuclidCircularA = 'EuclidCircularA';

class AppTheme {
  ThemeData getTheme(BuildContext context) => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF16236E),
        brightness: Brightness.light,
        fontFamily: kEuclidCircularA,
        textTheme: TextTheme(
            /* displayLarge: const TextStyle(
            fontFamily: kEuclidCircularA,
            fontSize: 57,
          ),
          headlineMedium: const TextStyle(
            fontFamily: kEuclidCircularA,
            fontSize: 28,
          ),
          titleLarge: const TextStyle(
            fontFamily: kEuclidCircularA,
            fontSize: 22,
          ),
          bodyLarge: const TextStyle(
            fontFamily: kEuclidCircularA,
            fontSize: 16,
          ),
          bodyMedium: const TextStyle(
            fontFamily: kEuclidCircularA,
            fontSize: 13,
          ),
          bodySmall: const TextStyle(
            fontFamily: kEuclidCircularA,
            fontSize: 12,
          ), */
            ),
      );
}
