import "package:flutter/material.dart";

MaterialColor createMaterialColor(Color color) {
  Map<int, Color> swatch = {
    50: color.withOpacity(0.1),
    100: color.withOpacity(0.2),
    200: color.withOpacity(0.3),
    300: color.withOpacity(0.4),
    400: color.withOpacity(0.5),
    500: color.withOpacity(0.6),
    600: color.withOpacity(0.7),
    700: color.withOpacity(0.8),
    800: color.withOpacity(0.9),
    900: color.withOpacity(1.0),
  };
  return MaterialColor(color.value, swatch);
}

const Color primaryColor = Colors.blueAccent;
const Color secondaryColor = Colors.blue;

class ColorLight {
  static Color primary = primaryColor;
  static Color secondary = secondaryColor;
  static const Color background = Color(0xFFFAFAFA);
  static const Color card = Color(0xFFFFFFFF);
  static const Color fontTitle = Color(0xFF202020);
  static const Color fontSubtitle = Color(0xFF737373);
  static const Color fontDisable = Color(0xFF9B9B9B);
  static const Color disabledButton = Color(0xFFB9B9B9);
  static const Color divider = Color(0xFFDCDCDC);

  static const Color success = Color(0xFF81C784);
  static const Color warning = Color(0xFFFFB74D);
  static const Color error = Color(0xFFE57373);
  static const Color info = Color(0xFF64B5F6);
}

class ColorDark {
  static Color primary = primaryColor;
  static Color secondary = secondaryColor;
  static const Color background = Color(0xFF303030);
  static const Color card = Color(0xFF424242);
  static const Color fontTitle = Color(0xFFFFFFFF);
  static const Color fontSubtitle = Color(0xFFC1C1C1);
  static const Color fontDisable = Color(0xFF989898);
  static const Color disabledButton = Color(0xFF6E6E6E);
  static const Color divider = Color(0xFF494949);

  static const Color success = Color.fromARGB(255, 98, 249, 106);
  static const Color warning = Color(0xFFF57C00);
  static const Color error = Color(0xFFD32F2F);
  static const Color info = Color(0xFF1976D2);
}
