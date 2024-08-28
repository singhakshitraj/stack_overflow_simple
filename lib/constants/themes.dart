import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme(BuildContext context) {
  return FlexThemeData.light(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xffaf2b3d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffdada),
      onPrimaryContainer: Color(0xff40000b),
      secondary: Color(0xff9d384b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffdad7),
      onSecondaryContainer: Color(0xff2c1513),
      tertiary: Color(0xff805159),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffd9de),
      onTertiaryContainer: Color(0xff321018),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfffcf5f9),
      onSurface: Color(0xff201a1a),
      onSurfaceVariant: Color(0xff524343),
      outline: Color(0xff857373),
      outlineVariant: Color(0xffd7c1c1),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff392e2f),
      onInverseSurface: Color(0xfffbeeed),
      inversePrimary: Color(0xffffb3b5),
      surfaceTint: Color(0xffaf2b3d),
    ),
  );
}

ThemeData darkTheme(BuildContext context) {
  return FlexThemeData.dark(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb3b5),
      onPrimary: Color(0xff680018),
      primaryContainer: Color(0xff8e0f28),
      onPrimaryContainer: Color(0xffffdada),
      secondary: Color(0xffe7bdb9),
      onSecondary: Color(0xff442927),
      secondaryContainer: Color(0xff5d3f3d),
      onSecondaryContainer: Color(0xffffdad7),
      tertiary: Color(0xfff2b7c0),
      onTertiary: Color(0xff4b252c),
      tertiaryContainer: Color(0xff653b42),
      onTertiaryContainer: Color(0xffffd9de),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffb4ab),
      surface: Color(0xff2b2121),
      onSurface: Color(0xffece0df),
      surfaceContainerHighest: Color(0xff5a4848),
      onSurfaceVariant: Color(0xffd7c1c1),
      outline: Color(0xff9f8c8c),
      outlineVariant: Color(0xff524343),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffecdddc),
      onInverseSurface: Color(0xff362f2f),
      inversePrimary: Color(0xffaf2b3d),
      surfaceTint: Color(0xffffb3b5),
    ),
  );
}

ButtonStyle buttonStyle() {
  return ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
  );
}
