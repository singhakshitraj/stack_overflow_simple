import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme(BuildContext context) {
  return FlexThemeData.light(
    scheme: FlexScheme.redWine,
    textTheme: GoogleFonts.quicksandTextTheme(Theme.of(context).textTheme),
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 7,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
  );
}

ThemeData darkTheme(BuildContext context) {
  return FlexThemeData.dark(
    scheme: FlexScheme.cyanM3,
    textTheme: GoogleFonts.quicksandTextTheme(),
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 20,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
  );
}

TextStyle whiteText = const TextStyle(
  color: Colors.white,
);
