import 'package:flutter/material.dart';
import 'package:idocit/common/providers/theme_provider.dart';
import 'package:idocit/constants/sizes.dart';
import 'colors.dart';

class ThemeConstants {
  static ThemeData getTheme(ThemeStyleType type) {
    switch (type) {
      case ThemeStyleType.light:
        return ThemeData.lerp(ThemeData.light(), _tLightTheme, 1.0);

      case ThemeStyleType.dark:
        return ThemeData.lerp(ThemeData.dark(), _tDarkTheme, 1.0);
    }
  }

  static final _tLightTheme = ThemeData(
    fontFamily: 'Roboto',
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorConstants.black500,
    canvasColor: ColorConstants.black400,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorConstants.black500,
      shadowColor: ColorConstants.black500,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        height: 18.0 / 16.0,
        color: ColorConstants.greyBlue500,
      ),
    ),
    navigationBarTheme: const NavigationBarThemeData(backgroundColor: ColorConstants.black450),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: ColorConstants.black450),
    dialogTheme: const DialogThemeData(
      backgroundColor: ColorConstants.black450,
      titleTextStyle: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        height: 28.0 / 24.0,
        color: ColorConstants.green500,
      ),
    ),
    textTheme: const TextTheme(
      /// Only for headline labels
      headlineLarge: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        height: 33.0 / 28.0,
        color: ColorConstants.green500,
      ),
      headlineMedium: TextStyle(
        fontSize: 21.0,
        fontWeight: FontWeight.w700,
        height: 25.0 / 21.0,
        color: ColorConstants.green500,
      ),
      headlineSmall: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        height: 21.0 / 18.0,
        color: ColorConstants.green500,
      ),

      /// Default text
      bodyLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        height: 21.0 / 16.0,
        color: ColorConstants.greyBlue500,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        height: 21.0 / 14.0,
        color: ColorConstants.greyBlue500,
      ),
      bodySmall: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w400,
        height: 21.0 / 13.0,
        color: ColorConstants.greyBlue500,
      ),

      /// For some text descriptions/subtitles
      titleLarge: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
        height: 18.0 / 15.0,
        color: ColorConstants.greyBlue450,
      ),
      titleMedium: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w400,
        height: 18.0 / 13.0,
        color: ColorConstants.greyBlue450,
      ),
      titleSmall: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        height: 15.0 / 12.0,
        color: ColorConstants.greyBlue450,
      ),

      /// Only for buttons
      displayMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        height: 18.0 / 16.0,
        color: ColorConstants.green500,
      ),
      displaySmall: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w400,
        height: 18.0 / 13.0,
        color: ColorConstants.green500,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      errorMaxLines: 3,
      helperMaxLines: 3,
      contentPadding: const EdgeInsets.all(SizeConstants.defaultPadding),
      iconColor: ColorConstants.greyBlue500,
      fillColor: ColorConstants.black500,
      labelStyle: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        height: 21.0 / 16.0,
        color: ColorConstants.greyBlue500,
      ),
      hintStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        height: 21.0 / 16.0,
        color: ColorConstants.greyBlue500.withOpacity(0.5),
      ),
      errorStyle: const TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w400,
        height: 21.0 / 13.0,
        color: ColorConstants.red500,
      ),
      helperStyle: TextStyle(
        fontSize: 13.0,
        height: 21.0 / 13.0,
        fontWeight: FontWeight.w400,
        color: ColorConstants.greyBlue500.withOpacity(0.6),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(width: 1.0, color: ColorConstants.green500),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(width: 1.0, color: ColorConstants.green500),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(width: 1.0, color: ColorConstants.green500),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(width: 1.0, color: ColorConstants.red500),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(width: 1.0, color: ColorConstants.red500),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(width: 1.0, color: ColorConstants.black200),
      ),
    ),
    dividerTheme: const DividerThemeData(color: ColorConstants.divider),
  );

  static final _tDarkTheme = ThemeData(
    fontFamily: 'Roboto',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorConstants.black500,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorConstants.black500,
      shadowColor: ColorConstants.black500,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        height: 18.0 / 16.0,
        color: ColorConstants.greyBlue500,
      ),
    ),
    navigationBarTheme: const NavigationBarThemeData(backgroundColor: ColorConstants.black450),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: ColorConstants.black450),
    dialogTheme: const DialogThemeData(
      backgroundColor: ColorConstants.black450,
      titleTextStyle: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        height: 28.0 / 24.0,
        color: ColorConstants.green500,
      ),
    ),
    textTheme: const TextTheme(
      /// Only for headline labels
      headlineLarge: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        height: 33.0 / 28.0,
        color: ColorConstants.green500,
      ),
      headlineMedium: TextStyle(
        fontSize: 21.0,
        fontWeight: FontWeight.w700,
        height: 25.0 / 21.0,
        color: ColorConstants.green500,
      ),
      headlineSmall: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        height: 21.0 / 18.0,
        color: ColorConstants.green500,
      ),

      /// Default text
      bodyLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        height: 21.0 / 16.0,
        color: ColorConstants.greyBlue500,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        height: 21.0 / 14.0,
        color: ColorConstants.greyBlue500,
      ),
      bodySmall: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w400,
        height: 21.0 / 13.0,
        color: ColorConstants.greyBlue500,
      ),

      /// For some text descriptions/subtitles
      titleLarge: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
        height: 18.0 / 15.0,
        color: ColorConstants.greyBlue450,
      ),
      titleMedium: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w400,
        height: 18.0 / 13.0,
        color: ColorConstants.greyBlue450,
      ),
      titleSmall: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        height: 15.0 / 12.0,
        color: ColorConstants.greyBlue450,
      ),

      /// Only for buttons
      displayMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        height: 18.0 / 16.0,
        color: ColorConstants.green500,
      ),
      displaySmall: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w400,
        height: 18.0 / 13.0,
        color: ColorConstants.green500,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      errorMaxLines: 3,
      helperMaxLines: 3,
      contentPadding: const EdgeInsets.all(SizeConstants.defaultPadding),
      iconColor: ColorConstants.greyBlue500,
      fillColor: ColorConstants.black500,
      labelStyle: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        height: 21.0 / 16.0,
        color: ColorConstants.greyBlue500,
      ),
      hintStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        height: 21.0 / 16.0,
        color: ColorConstants.greyBlue500.withOpacity(0.5),
      ),
      errorStyle: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        height: 21.0 / 14.0,
        color: ColorConstants.red500,
      ),
      helperStyle: TextStyle(
        fontSize: 13.0,
        height: 21.0 / 13.0,
        fontWeight: FontWeight.w400,
        color: ColorConstants.greyBlue500.withOpacity(0.6),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(width: 1.0, color: ColorConstants.green500),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(width: 1.0, color: ColorConstants.green500),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(width: 1.0, color: ColorConstants.green500),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(width: 1.0, color: ColorConstants.red500),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(width: 1.0, color: ColorConstants.red500),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(width: 1.0, color: ColorConstants.black200),
      ),
    ),
    dividerTheme: const DividerThemeData(color: ColorConstants.divider),
  );
}
