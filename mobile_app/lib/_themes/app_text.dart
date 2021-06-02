import 'package:flutter/material.dart';

import 'colors.dart';

abstract class AppText extends StatelessWidget {
  final bold;
  final label;
  final double fontSize;
  final theme;

  AppText(
      {required this.label,
      this.bold = false,
      this.fontSize = 19,
      required this.theme});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
          fontSize: fontSize,
          height: 1.5,
          color: theme,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal),
    );
  }
}

class AppTitle extends AppText {
  AppTitle(label)
      : super(
            label: label,
            bold: true,
            fontSize: 24,
            theme: ThemeColors.textLight);
}

class AppSubTitle extends AppText {
  AppSubTitle(label) : super(label: label, theme: ThemeColors.textGray, fontSize: 20);
}

class AppSectionTitle extends AppText {
  AppSectionTitle(label)
      : super(
            label: label,
            theme: ThemeColors.textHighlighted,
            bold: true,
            fontSize: 23);
}

class AppSectionDescription extends AppText {
  AppSectionDescription(label)
      : super(label: label, theme: ThemeColors.textLight);
}
