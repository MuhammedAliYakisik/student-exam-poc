import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constant/color_constant.dart';


class AppTheme {
  final theme = ThemeData.light().copyWith(
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.light().textTheme,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
      ),
      scaffoldBackgroundColor: ColorConstant.instance.primaryColor

  );
}