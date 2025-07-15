import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color _primaryColor = Color(0xFF758BFD);
  static const Color _primaryColorLight = Color.fromRGBO(199, 204, 255, 1);
  static const Color _primaryColorDark = Color(0xFF27187E);
  static const Color _secondaryLightColor = Color.fromRGBO(235, 236, 248, 1);
  static const Color _secondaryDarkColor = Color(0xFF1E1E1E);
  static const Color _whiteColor = Color(0xFFF1F2F6);
  static const Color _blackColor = Colors.black;
  static const Color _contrastColor = Color.fromARGB(255, 82, 166, 187);

  static ThemeData lightTheme = ThemeData(
    splashColor: Color.fromRGBO(219, 221, 245, 1),
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: _primaryColor,
    primaryColorLight: _primaryColorLight,
    primaryColorDark: _primaryColorDark,
    scaffoldBackgroundColor: _secondaryLightColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _whiteColor
    ),
    colorScheme: ColorScheme.light(
      primary: _primaryColor,
      primaryContainer: _primaryColorLight,
      onPrimary: _whiteColor,
      secondary: _contrastColor,
      onSecondary: Colors.black,
      surface: _secondaryLightColor,
      onSurface: Colors.black87,
      error: Colors.red.shade700,
      onError: _whiteColor,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _primaryColor,
      foregroundColor: _whiteColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0.0,
      shadowColor: Colors.transparent,
      centerTitle: true,
      iconTheme: IconThemeData(color: _whiteColor),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _contrastColor,
      foregroundColor: Colors.black,
    ),
    cardTheme: CardThemeData(
      color: _whiteColor,
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: AppTheme._primaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: _primaryColorDark, width: 2.0),
      ),
      labelStyle: GoogleFonts.inter(color: _primaryColorDark),
      hintStyle: GoogleFonts.inter(color: Colors.grey.shade600),
      fillColor: _whiteColor,
      filled: false,
      prefixIconColor: _primaryColorDark,
      suffixIconColor: _primaryColorDark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed)) {
            return _primaryColorDark;
          } else if (states.contains(WidgetState.disabled)) {
            return _primaryColorLight;
          }
          return _primaryColor;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed)) {
            return _primaryColor;
          } else if (states.contains(WidgetState.disabled)) {
            return _primaryColor;
          }
          return _whiteColor;
        }),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        ),
      ),
    ),
    textTheme: GoogleFonts.interTextTheme(
      ThemeData.light().textTheme,
    ).apply(bodyColor: Colors.black87, displayColor: Colors.black87),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: _primaryColor,
    primaryColorLight: _primaryColorLight,
    primaryColorDark: _primaryColor,
    scaffoldBackgroundColor: _blackColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _blackColor
    ),
    colorScheme: ColorScheme.dark(
      primary: _primaryColor,
      primaryContainer: _blackColor,
      onPrimary: _whiteColor,
      secondary: _contrastColor,
      onSecondary: Colors.black,
      surface: _secondaryDarkColor,
      onSurface: _whiteColor,
      error: Colors.red.shade400,
      onError: _blackColor,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _secondaryDarkColor,
      foregroundColor: _blackColor,
      elevation: 4.0,
      centerTitle: true,
      iconTheme: IconThemeData(color: _whiteColor),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _contrastColor,
      foregroundColor: Colors.black,
    ),
    cardTheme: CardThemeData(
      color: _secondaryDarkColor,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: _primaryColor,
      suffixIconColor: _primaryColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: _primaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: _primaryColorLight, width: 2.0),
      ),
      labelStyle: GoogleFonts.inter(color: _primaryColorLight),
      hintStyle: GoogleFonts.inter(color:_primaryColorLight),
      fillColor: _secondaryDarkColor,
      filled: true,
    ),
    textTheme: GoogleFonts.interTextTheme(
      ThemeData.dark().textTheme,
    ).apply(bodyColor: _whiteColor, displayColor: _whiteColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed)) {
            return _primaryColorDark;
          } else if (states.contains(WidgetState.disabled)) {
            return _primaryColorLight;
          }
          return _primaryColor;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed)) {
            return _primaryColor;
          } else if (states.contains(WidgetState.disabled)) {
            return _primaryColor;
          }
          return _whiteColor;
        }),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        ),
      ),
    ),
  );
}
