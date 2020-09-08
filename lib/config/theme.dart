import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

// Our light/Primary Theme
ThemeData lightThemeData(BuildContext context) {
  return ThemeData(
    appBarTheme: appBarTheme,
    primaryColor: kPrimaryColor,
    accentColor: kAccentLightColor,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      secondary: kSecondaryLightColor,
      // on light theme surface = Colors.white by default
    ),
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: kBodyTextColorLight),
    accentIconTheme: IconThemeData(color: kAccentIconLightColor),
    primaryIconTheme: IconThemeData(color: kPrimaryIconLightColor),
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      bodyText1: TextStyle(color: kBodyTextColorLight),
      bodyText2: TextStyle(color: kBodyTextColorLight),
      headline6: TextStyle(color: kTitleTextLightColor),
      headline5: TextStyle(color: kTitleTextLightColor),
      headline4: TextStyle(color: kTitleTextLightColor, fontSize: 32),
      headline3: TextStyle(color: kTitleTextLightColor),
      headline2: TextStyle(color: kTitleTextLightColor),
      headline1: TextStyle(color: kTitleTextLightColor, fontSize: 80),
      caption: TextStyle(color: kTitleTextLightColor),
    ),
    inputDecorationTheme: inputDecorationTheme(false),
  );
}

// Dark Them
ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    accentColor: kAccentDarkColor,
    scaffoldBackgroundColor: kBackgroundDarkColor,
    appBarTheme: appBarTheme,
    colorScheme: ColorScheme.light(
      secondary: kSecondaryDarkColor,
      surface: kSurfaceDarkColor,
    ),
    backgroundColor: kBackgroundDarkColor,
    iconTheme: IconThemeData(color: kBodyTextColorDark),
    accentIconTheme: IconThemeData(color: kAccentIconDarkColor),
    primaryIconTheme: IconThemeData(color: kPrimaryIconDarkColor),
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      bodyText1: TextStyle(color: kBodyTextColorDark),
      bodyText2: TextStyle(color: kBodyTextColorDark),
      headline6: TextStyle(color: kTitleTextDarkColor),
      headline5: TextStyle(color: kTitleTextDarkColor, fontSize: 28),
      headline4: TextStyle(color: kTitleTextDarkColor, fontSize: 32),
      headline3: TextStyle(color: kTitleTextDarkColor, fontSize: 46),
      headline2: TextStyle(color: kTitleTextDarkColor),
      headline1: TextStyle(color: kTitleTextDarkColor, fontSize: 80),
      caption: TextStyle(color: kTitleTextDarkColor),
    ),
    inputDecorationTheme: inputDecorationTheme(true),
  );
}

AppBarTheme appBarTheme = AppBarTheme(color: Colors.transparent, elevation: 0);

InputDecorationTheme inputDecorationTheme(bool isDarkMode) {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    gapPadding: 5,
  );
  OutlineInputBorder focuslineInputBorder =
      outlineInputBorder.copyWith(borderSide: BorderSide(color: Colors.orange));
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    // floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.all(20),
    enabledBorder: outlineInputBorder,
    focusedBorder: focuslineInputBorder,
    border: outlineInputBorder,
  );
}
