import 'dart:ui';

class ColorConstant {

  static final ColorConstant _instance = ColorConstant._init();
  static ColorConstant get instance => _instance;
  ColorConstant._init();

  final primaryColor = const Color(0xFFF8F9FA);
  final secondaryColor = const Color(0xFF0055BB);


  //text
  final textPrimaryColor = const Color(0xFF1A1D1E);
  final textSecondaryColor = const Color(0xFF6B7280);


  //textfield
  final textFieldBackgroundColor = const Color(0xFFF3F5F7);
  final textFieldLabelColor = const Color(0xFF5A739C);
  final textFieldContentColor = const Color(0xFF8D9CB5);

  //snackbar
  final errorColor = const Color(0xFFd9534f);
  final succesfullColor = const Color(0xFF5cb85c);
  final waitingColor = const Color(0xFAF6C903);
  final warningColor = const Color(0xFFD9AA00);
  final infoColor = const Color(0xFF883fff);

}