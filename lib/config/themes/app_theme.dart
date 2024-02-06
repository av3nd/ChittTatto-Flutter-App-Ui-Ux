import 'package:chitto_tatto/config/themes/app_color_constant.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static getApplicationTheme() {
    return ThemeData(
      colorScheme:
          const ColorScheme.light(primary: AppColorConstant.primaryColor),
      fontFamily: 'Open Sans',
      // useMaterial3: true,
      // appbartheme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColorConstant.appBarCOlor,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),

      // bottom navigation bar theme
      // bottomAppBarTheme: BottomAppBarTheme(

      // )
    );
  }
}
