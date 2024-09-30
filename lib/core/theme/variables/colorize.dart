part of '../app_theme.dart';

class Colorize {
  static final Colorize _instance = Colorize._internal();

  factory Colorize() => _instance;

  Colorize._internal();

  // Bodytext
  Color get defaultSurface => const Color(0xFF0C111D);

  // Bodytext
  Color get bodyText => const Color(0xFF1F222E);
  Color get bodyNegativeText => const Color(0xFFFFFFFF);

  Color get bodySubtitleDark => chilledGray300;

  // Primary
  // Color _primaryFill = const Color(0xFF1451E1);
  // Color _primaryStroke = const Color(0xFF1451E1);
  // Color _primaryText = const Color(0xFF1041B4);

  final Color _primaryFill = const Color(0xFF16236E);
  final Color _primaryStroke = const Color(0xFF16236E);
  final Color _primaryText = const Color(0xFF16236E);

  final Color _accentFill = const Color(0xFF149CD7);

  Color get primaryFill => _primaryFill;
  Color get primaryStroke => _primaryStroke;
  Color get primaryText => _primaryText;

  Color get accentFill => _accentFill;

  // Colors
  Color get chilledGray100 => const Color(0xFFCDD1DC);
  Color get chilledGray300 => const Color(0xFF9095A7);
}
