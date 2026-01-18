import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFFF7F27),
      surfaceTint: Color(0xff506168),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff66777f),
      onPrimaryContainer: Color(0xfffafdff),
      secondary: Color(0xff9b4500),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff506168),
      onSecondaryContainer: Color(0xff612900),
      tertiary: Color(0xff635869),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff7c7182),
      onTertiaryContainer: Color(0xfffffbff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffbf9f9),
      onSurface: Color(0xff1b1c1c),
      onSurfaceVariant: Color(0xff43474a),
      outline: Color(0xff73787a),
      outlineVariant: Color(0xffc3c7ca),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303031),
      inversePrimary: Color(0xffb8c9d2),
      primaryFixed: Color(0xffd4e5ee),
      onPrimaryFixed: Color(0xff0d1e24),
      primaryFixedDim: Color(0xffb8c9d2),
      onPrimaryFixedVariant: Color(0xff394950),
      secondaryFixed: Color(0xffffdbc9),
      onSecondaryFixed: Color(0xff331200),
      secondaryFixedDim: Color(0xffffb68e),
      onSecondaryFixedVariant: Color(0xff763300),
      tertiaryFixed: Color(0xffecdef2),
      onTertiaryFixed: Color(0xff201826),
      tertiaryFixedDim: Color(0xffd0c2d5),
      onTertiaryFixedVariant: Color(0xff4d4353),
      surfaceDim: Color(0xffdbd9da),
      surfaceBright: Color(0xfffbf9f9),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff5f3f3),
      surfaceContainer: Color(0xffefeded),
      surfaceContainerHigh: Color(0xffeae8e8),
      surfaceContainerHighest: Color(0xffe4e2e2),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb8c9d2),
      surfaceTint: Color(0xffb8c9d2),
      onPrimary: Color(0xff233339),
      primaryContainer: Color(0xff82939b),
      onPrimaryContainer: Color(0xff102027),
      secondary: Color(0xffffb68e),
      onSecondary: Color(0xff532200),
      secondaryContainer: Color(0xffff7f27),
      onSecondaryContainer: Color(0xff612900),
      tertiary: Color(0xffd0c2d5),
      onTertiary: Color(0xff362d3c),
      tertiaryContainer: Color(0xff998c9f),
      onTertiaryContainer: Color(0xff231a29),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff131314),
      onSurface: Color(0xffe4e2e2),
      onSurfaceVariant: Color(0xffc3c7ca),
      outline: Color(0xff8d9194),
      outlineVariant: Color(0xff43474a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e2e2),
      inversePrimary: Color(0xff506168),
      primaryFixed: Color(0xffd4e5ee),
      onPrimaryFixed: Color(0xff0d1e24),
      primaryFixedDim: Color(0xffb8c9d2),
      onPrimaryFixedVariant: Color(0xff394950),
      secondaryFixed: Color(0xffffdbc9),
      onSecondaryFixed: Color(0xff331200),
      secondaryFixedDim: Color(0xffffb68e),
      onSecondaryFixedVariant: Color(0xff763300),
      tertiaryFixed: Color(0xffecdef2),
      onTertiaryFixed: Color(0xff201826),
      tertiaryFixedDim: Color(0xffd0c2d5),
      onTertiaryFixedVariant: Color(0xff4d4353),
      surfaceDim: Color(0xff131314),
      surfaceBright: Color(0xff39393a),
      surfaceContainerLowest: Color(0xff0d0e0f),
      surfaceContainerLow: Color(0xff1b1c1c),
      surfaceContainer: Color(0xff1f2020),
      surfaceContainerHigh: Color(0xff292a2a),
      surfaceContainerHighest: Color(0xff343535),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    fontFamily: 'Poppins',
    textTheme: textTheme.apply(bodyColor: colorScheme.onSurface, displayColor: colorScheme.onSurface),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({required this.color, required this.onColor, required this.colorContainer, required this.onColorContainer});

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
