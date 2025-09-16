import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class ThemeUSM {
  static Color buttonColor = Color(0xFF2f4073);
  static Color whiteColor = Color.fromARGB(255, 213, 206, 194);
  static Color scaffoldBackgroundColor = Color.fromARGB(255, 228, 228, 228);
  static Color blackColor = const Color.fromARGB(255, 0, 0, 0);
  static Color cardColor = Color.fromARGB(255, 85, 104, 161);
  static Color purpleUSMColor = Color.fromARGB(255, 130, 7, 230);
  static Color shadowColor = Color.fromARGB(255, 201, 199, 198);
  static Color backgroundColorWhite = Colors.white12;
}

class USMThemeData {
  static ThemeData themeData = ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: SharedAxisPageTransitionsBuilder(
          transitionType: SharedAxisTransitionType.horizontal,
        ),
        TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(
          transitionType: SharedAxisTransitionType.scaled,
        ),
      },
    ),
    cardColor: ThemeUSM.cardColor,
    dividerColor: ThemeUSM.purpleUSMColor,
    shadowColor: ThemeUSM.shadowColor,
    primaryColor: ThemeUSM.whiteColor,
    scaffoldBackgroundColor: ThemeUSM.scaffoldBackgroundColor,
    drawerTheme: USMDrawerTheme.drawerTheme,
    appBarTheme: USMAppBarTheme.appBarTheme,
    buttonTheme: USMButtonThemeData.buttonThemeData,
    textTheme: USMThemeText.textTheme,
    primaryTextTheme: USMThemeText.discursiveTheme,
    useMaterial3: true,
  );
}

class USMDrawerTheme {
  static DrawerThemeData drawerTheme = DrawerThemeData(
    backgroundColor: ThemeUSM.blackColor,
    elevation: 10,
  );
}

class USMAppBarTheme {
  static AppBarTheme appBarTheme = AppBarTheme(
      iconTheme: IconThemeData(
        color: ThemeUSM.whiteColor,
        applyTextScaling: true,
      ),
      actionsIconTheme: IconThemeData(applyTextScaling: true),
      backgroundColor: ThemeUSM.blackColor,
      elevation: 20,
      titleTextStyle: TextStyle(color: ThemeUSM.whiteColor));
}

class USMButtonThemeData {
  static ButtonThemeData buttonThemeData = ButtonThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: ThemeUSM.buttonColor,
      secondary: ThemeUSM.whiteColor,
    ),
    buttonColor: ThemeUSM.buttonColor,
  );
}

class USMThemeText {
  static TextTheme discursiveTheme = TextTheme(
    displayLarge: discursiveLarge,
    displayMedium: discursiveMedium,
    displaySmall: discursiveSmall,
    bodySmall: discursiveSmallBlack,
    bodyMedium: discursiveMediumBlack,
    bodyLarge: discursiveLargeBlack,
  );

  static TextStyle discursiveLarge = TextStyle(
      fontFamily: "Libertinus", fontSize: 26, color: ThemeUSM.whiteColor);
  static TextStyle discursiveMedium = TextStyle(
      fontFamily: "Libertinus", fontSize: 23, color: ThemeUSM.whiteColor);
  static TextStyle discursiveSmall = TextStyle(
      fontFamily: "Libertinus", fontSize: 20, color: ThemeUSM.whiteColor);
  //text color black
  static TextStyle discursiveSmallBlack = TextStyle(
      fontFamily: "Libertinus", fontSize: 20, color: ThemeUSM.blackColor);
  static TextStyle discursiveMediumBlack = TextStyle(
      fontFamily: "Libertinus", fontSize: 23, color: ThemeUSM.blackColor);
  static TextStyle discursiveLargeBlack = TextStyle(
      fontFamily: "Libertinus", fontSize: 26, color: ThemeUSM.blackColor);

  static TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
        fontFamily: "Ubuntu", fontSize: 24, color: ThemeUSM.whiteColor),
    displayMedium: TextStyle(
        fontFamily: "Ubuntu", fontSize: 21, color: ThemeUSM.whiteColor),
    displaySmall: TextStyle(
        fontFamily: "Ubuntu", fontSize: 18, color: ThemeUSM.whiteColor),
    //text color black
    bodySmall: TextStyle(
        fontFamily: "Ubuntu", fontSize: 18, color: ThemeUSM.blackColor),
    bodyMedium: TextStyle(
        fontFamily: "Ubuntu", fontSize: 21, color: ThemeUSM.blackColor),
    bodyLarge: TextStyle(
        fontFamily: "Ubuntu", fontSize: 24, color: ThemeUSM.blackColor),
  );
}
