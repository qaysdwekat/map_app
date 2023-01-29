import 'package:flutter/material.dart';
import 'colors.dart';

TextTheme buildTextTheme(
  TextTheme base,
  String? language, [
  String fontFamily = 'Archivo',
  String fontHeader = 'Archivo',
  bool isPrimaryTextTheme = false,
  Color titleColor = Colors.black,
  Color bodyColor = Colors.black,
]) {
  if (isPrimaryTextTheme) {
    return base
        .copyWith(
          displayLarge: base.displayLarge?.copyWith(
            fontFamily: fontFamily,
            color: bodyColor,
          ),
          displayMedium: base.displayMedium?.copyWith(
            fontFamily: fontFamily,
            color: bodyColor,
          ),
          displaySmall: base.displaySmall?.copyWith(
            fontFamily: fontFamily,
            color: bodyColor,
          ),
          headlineLarge: base.headlineLarge?.copyWith(
            fontFamily: fontFamily,
            color: titleColor,
          ),
          headlineMedium: base.headlineMedium?.copyWith(
            fontFamily: fontFamily,
            color: titleColor,
          ),
          headlineSmall: base.headlineSmall?.copyWith(
            fontFamily: fontFamily,
            color: titleColor,
          ),
          titleLarge: base.titleLarge?.copyWith(
            fontFamily: fontFamily,
            fontWeight: FontWeight.w800,
            color: Colors.amber,
          ),
          titleMedium: base.titleMedium?.copyWith(
            fontFamily: fontFamily,
            fontSize: 17,
            color: titleColor,
          ),
          titleSmall: base.titleSmall?.copyWith(
            fontFamily: fontFamily,
            fontSize: 12,
            color: titleColor,
          ),
          bodyLarge: base.bodyLarge?.copyWith(
            fontFamily: fontFamily,
            color: bodyColor,
          ),
          bodyMedium: base.bodyMedium?.copyWith(
            fontFamily: fontFamily,
            color: bodyColor,
          ),
          bodySmall: base.bodySmall?.copyWith(
            fontFamily: fontFamily,
            color: bodyColor,
          ),
          labelLarge: base.labelLarge?.copyWith(
            fontFamily: fontFamily,
            color: titleColor,
          ),
          labelMedium: base.labelMedium?.copyWith(
            fontFamily: fontFamily,
            color: titleColor,
          ),
          labelSmall: base.labelSmall?.copyWith(
            fontFamily: fontFamily,
            color: titleColor,
          ),
        )
        .apply(
          displayColor: kGrey900,
          bodyColor: kGrey900,
        );
  } else {
    return base
        .copyWith(
          headline1: base.headline1?.copyWith(fontWeight: FontWeight.w700, fontFamily: fontFamily),
          headline2: base.headline2?.copyWith(fontWeight: FontWeight.w700, fontFamily: fontFamily),
          headline3: base.headline3?.copyWith(fontWeight: FontWeight.w700, fontFamily: fontFamily),
          headline4: base.headline4?.copyWith(fontWeight: FontWeight.w600, fontFamily: fontFamily),
          headline5: base.headline5?.copyWith(fontWeight: FontWeight.w500, fontFamily: fontFamily),
          headline6: base.headline6?.copyWith(fontWeight: FontWeight.w400, fontFamily: fontFamily),
          subtitle1: base.subtitle1?.copyWith(fontFamily: fontFamily),
          subtitle2: base.subtitle2?.copyWith(fontFamily: fontFamily),
          bodyText1: base.bodyText1?.copyWith(fontFamily: fontFamily),
          bodyText2: base.bodyText2?.copyWith(fontFamily: fontFamily),
          caption: base.caption?.copyWith(fontFamily: fontFamily),
          button: base.button?.copyWith(fontSize: 16, fontFamily: fontFamily),
          overline: base.overline?.copyWith(fontFamily: fontFamily),
        )
        .apply(
          displayColor: kGrey900,
          bodyColor: kGrey900,
        );
  }
}
