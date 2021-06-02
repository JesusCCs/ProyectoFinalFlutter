import 'dart:ui';

class ColorFilters {
  static final greyscale = ColorFilter.matrix(<double>[
    /// greyscale filter
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0, 0, 0, 1, 0
  ]);
}

class ThemeColors {
  static final darkBg = const Color.fromRGBO(38, 38, 38, 15);
  static final textGray = const Color.fromRGBO(38, 38, 38, 15);
  static final textLight = const Color.fromRGBO(251, 251, 251, 98);
  static final textHighlighted = const  Color.fromRGBO(255, 169, 0, 100);
}