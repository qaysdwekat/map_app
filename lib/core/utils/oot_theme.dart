import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'fonts.dart';

IconThemeData customIconTheme(IconThemeData original) {
  return original.copyWith(color: kGrey900);
}

ThemeData buildOOTTheme(
  String? language, [
  String fontFamily = 'Archivo',
  String fontHeader = 'Archivo',
  Color titleColor = Colors.black,
  Color bodyColor = Colors.black,
]) {
  final base = ThemeData.light().copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeThroughPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  return base.copyWith(
    brightness: Brightness.light,
    cardColor: Colors.white,
    errorColor: kErrorRed,
    buttonTheme:
        const ButtonThemeData(colorScheme: kColorScheme, textTheme: ButtonTextTheme.normal, buttonColor: kDarkBG),
    primaryColorLight: kLightBG,
    primaryIconTheme: customIconTheme(base.iconTheme),
    textTheme: buildTextTheme(
      base.textTheme,
      language,
      fontFamily,
      fontHeader,
      false,
      titleColor,
      bodyColor,
    ),
    primaryTextTheme: buildTextTheme(
      base.primaryTextTheme,
      language,
      fontFamily,
      fontHeader,
      true,
      titleColor,
      bodyColor,
    ),
    iconTheme: customIconTheme(base.iconTheme),
    hintColor: Colors.black26,
    backgroundColor: Colors.white,
    primaryColor: kLightPrimary,
    scaffoldBackgroundColor: kLightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        color: kDarkBG,
        fontSize: 18.0,
        fontWeight: FontWeight.w800,
      ),
      iconTheme: const IconThemeData(
        color: kLightAccent,
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    }),
    inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Color(0xffB0B5DD),
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Color(0xffB0B5DD),
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Color(0xffB0B5DD),
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusColor: const Color(0xff7D68F5),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Color(0xff7D68F5),
          ),
          borderRadius: BorderRadius.circular(8.0),
        )),
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xff7D68F5),
            width: 3.0,
          ),
        ),
      ),
      overlayColor: MaterialStateColor.resolveWith((states) => const Color(0xff7D68F5)),
      labelColor: const Color(0xff7D68F5),
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      labelPadding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      unselectedLabelColor: Colors.black,
      unselectedLabelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.black,
      selectedLabelStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        fontSize: 10.0,
        fontFamily: fontFamily,
      ),
      unselectedLabelStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        fontSize: 10.0,
        fontFamily: fontFamily,
      ),
    ),
    colorScheme: kColorScheme.copyWith(secondary: kLightAccent),
  );
}
