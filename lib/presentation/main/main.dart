// ignore: depend_on_referenced_packages
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../core/base/states/general_state.dart';
import '../../core/routes/oot_navigate.dart';
import '../../core/routes/route.dart';
import '../../core/utils/oot_theme.dart';
import '../../environments/config/config.dart';
import '../../generated/l10n.dart';
import '../splash/splash_screen.dart';
// import '../../environments/config/config.dart';
// import '../../generated/l10n.dart';

class OOTApp extends StatelessWidget {
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    final language = 'en';
    final botToastBuilder = BotToastInit();
    Color backgroundColor = Colors.white;
    Color primaryColor = Colors.red;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: backgroundColor,
        systemNavigationBarDividerColor: primaryColor,
        systemNavigationBarColor: primaryColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: MaterialApp(
        routes: Routes.getAll(),
        home: SplashScreen(),
        onGenerateRoute: Routes.getRouteGenerate,
        navigatorKey: OOTNavigate.navigatorKey,
        builder: (context, child) {
          child = MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
          child = botToastBuilder(context, child);
          return child;
        },
        theme: getTheme(
          isDarkTheme,
          context,
          language,
          Config(),
        ),
        debugShowCheckedModeBanner: false,
        title: 'OOT',
        locale: Locale(language),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
      ),
    );
  }

  ThemeData getTheme(bool isDarkTheme, context, code, Config? config) {
    // return isDarkTheme
    //     ? getDarkTheme(context, code, config)
    //     : getLightTheme(context, code, config);
    return getLightTheme(context, code, config);
  }

  /// Build the App Theme
  ThemeData getLightTheme(context, code, Config? config) {
    Color backgroundColor = Colors.white;
    Color primaryColor = Colors.red;
    Color textColor = Colors.black;
    Color bodyColor = Colors.black;
    Color secondaryColor = Colors.white;

    ThemeData themeData;
    themeData = buildOOTTheme(
      code,
      code == 'ar' ? 'Avenir' : 'Nunito_Sans',
      code == 'ar' ? 'Avenir' : 'Nunito_Sans',
      textColor,
      bodyColor,
    );
    themeData = themeData.copyWith(
        primaryColor: primaryColor,
        secondaryHeaderColor: secondaryColor,
        backgroundColor: backgroundColor,
        primaryColorLight: primaryColor,
        textTheme: themeData.textTheme.apply(
          displayColor: textColor,
          bodyColor: bodyColor,
        ),
        colorScheme: themeData.colorScheme.copyWith(
          background: backgroundColor,
          primary: primaryColor,
          secondary: secondaryColor,
        ));

    return themeData;
  }

  /// Build the App Theme
  // ThemeData getDarkTheme(context, code, Config? config) {
  //   Color backgroundColor = HexColor('#3C3C3E');
  //   Color primaryColor = HexColor('#FFFFFF');
  //   Color textColor = HexColor('#FFFFFF');
  //   Color secondaryColor = HexColor('#66A93B');

  //   ThemeData themeData;
  //   themeData = buildVatrinDarkTheme(code);
  //   themeData = themeData.copyWith(
  //       backgroundColor: backgroundColor,
  //       primaryColorLight: primaryColor,
  //       secondaryHeaderColor: secondaryColor,
  //       cardColor: backgroundColor,
  //       textTheme: themeData.textTheme.apply(
  //         displayColor: textColor,
  //         bodyColor: textColor,
  //       ),
  //       colorScheme: themeData.colorScheme.copyWith(
  //         secondary: secondaryColor,
  //       ));

  //   return themeData;
  // }

}
