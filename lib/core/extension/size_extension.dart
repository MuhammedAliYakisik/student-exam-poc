import 'package:flutter/cupertino.dart';

extension ContextExtension on BuildContext {
  double dynamicHeight(double value) => MediaQuery.of(this).size.height * value;
  double dynamicWeight(double value) => MediaQuery.of(this).size.width * value;
}

extension IconSizeExtension on BuildContext {
  double responsiveIconSize(double factor) {
    return MediaQuery.of(this).size.shortestSide * factor;
  }
}
