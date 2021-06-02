import 'dart:ui';

import 'package:flutter/material.dart';

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
  static final darkBg = const Color.fromRGBO(38, 38, 38, 1);
  static final textGray = const Color.fromRGBO(220, 220, 220, 0.71);
  static final textLight = Colors.white;
  static final textHighlighted = const  Color.fromRGBO(255, 169, 0, 1);
}