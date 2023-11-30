import 'package:flutter/material.dart';
import 'package:roadmap/core/constants/colors.dart';

class TAppBarTheme {
  TAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Color(0xFF292929),
    iconTheme: IconThemeData(color: tWhiteColor, size: 18),
    actionsIconTheme: IconThemeData(color: tWhiteColor, size: 18),
  );

  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: tWhiteColor, size: 18),
    actionsIconTheme: IconThemeData(color: tWhiteColor, size: 18),
  );
}
