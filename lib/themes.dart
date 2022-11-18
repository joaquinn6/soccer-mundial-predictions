import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  applyElevationOverlayColor: true,
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: const Color(0xFF9E3E5A),
  primarySwatch: const MaterialColor(
    0xFFEBAAB0,
    <int, Color>{
      50: Color(0xFFF1E4E8),
      100: Color(0xFFDDBBC5),
      200: Color(0xFFC68E9E),
      300: Color(0xFFAF6077),
      400: Color(0xFF9E3E5A),
      500: Color(0xFF8D1C3D),
      600: Color(0xFF851937),
      700: Color(0xFF7A142F),
      800: Color(0xFF701127),
      900: Color(0xFF5D091A)
    },
  ),
  canvasColor: const Color(0xFFF1E4E8),
  dividerColor: const Color(0xFFE1C396),
  textTheme: GoogleFonts.rubikTextTheme(),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFEBAAB0),
    foregroundColor: Color(0xDF404041),
    systemOverlayStyle: SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(),
  ),
  iconTheme: const IconThemeData(
    color: Color(0xFF000000),
  ),
  drawerTheme: const DrawerThemeData(
    elevation: 2.0,
    backgroundColor: Color(0xFFEBAAB0),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFEBAAB0),
          foregroundColor: Colors.black)),
);

ThemeData darkTheme = ThemeData(
    applyElevationOverlayColor: true,
    useMaterial3: true,
    brightness: Brightness.dark,
    primarySwatch: const MaterialColor(
      0xFF8D1C3D,
      <int, Color>{
        50: Color(0xFFF1E4E8),
        100: Color(0xFFDDBBC5),
        200: Color(0xFFC68E9E),
        300: Color(0xFFAF6077),
        400: Color(0xFF9E3E5A),
        500: Color(0xFF8D1C3D),
        600: Color(0xFF851937),
        700: Color(0xFF7A142F),
        800: Color(0xFF701127),
        900: Color(0xFF5D091A)
      },
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8D1C3D),
            foregroundColor: Colors.white)),
    canvasColor: const Color(0xEF161616),
    dividerColor: const Color(0xFFE1C396),
    appBarTheme: const AppBarTheme(
      elevation: 2.0,
      backgroundColor: Color(0xFF8D1C3D),
      foregroundColor: Color(0xFFFFFFFF),
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFFFFFFFF),
    ),
    primaryColor: const Color(0xFF8D1C3D),
    textTheme: GoogleFonts.rubikTextTheme(
        ThemeData(brightness: Brightness.dark).textTheme),
    drawerTheme: const DrawerThemeData(
      elevation: 2.0,
      backgroundColor: Color(0xFF8D1C3D),
    ));
