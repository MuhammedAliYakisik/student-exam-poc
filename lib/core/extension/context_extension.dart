
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;

  double get veryLowValue => height * 0.005;
  double get lowValue => height * 0.01;
  double get normalValue => height * 0.02;
  double get mediumValue => height * 0.04;
  double get highValue => height * 0.1;

  double get veryLowHeightValue => height * 0.005;
  double get lowHeightValue => height * 0.01;
  double get normalHeightValue => height * 0.04;
  double get mediumHeightValue => height * 0.07;
  double get highHeightValue => height * 0.1;

  double get veryLowWidthValue => width * 0.05;
  double get lowWidthValue => width * 0.10;
  double get normalWidthValue => width * 0.30;
  double get mediumWidthValue => width * 0.60;
  double get highWidthValue => width * 1;


}

extension PaddingExtensionAll on BuildContext {
  EdgeInsets get paddingVeryLow => EdgeInsets.all(veryLowValue);
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);
}

extension PaddingExtensionSymetric on BuildContext {
  EdgeInsets get paddingVeryLowVertical => EdgeInsets.symmetric(vertical: veryLowValue);
  EdgeInsets get paddingLowVertical => EdgeInsets.symmetric(vertical: lowValue);
  EdgeInsets get paddingNormalVertical =>
      EdgeInsets.symmetric(vertical: normalValue);
  EdgeInsets get paddingMediumVertical =>
      EdgeInsets.symmetric(vertical: mediumValue);
  EdgeInsets get paddingHighVertical =>
      EdgeInsets.symmetric(vertical: highValue);

  EdgeInsets get paddingVeryLowHorizontal =>
      EdgeInsets.symmetric(horizontal: veryLowValue);
  EdgeInsets get paddingLowHorizontal =>
      EdgeInsets.symmetric(horizontal: lowValue);
  EdgeInsets get paddingNormalHorizontal =>
      EdgeInsets.symmetric(horizontal: normalValue);
  EdgeInsets get paddingMediumHorizontal =>
      EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get paddingHighHorizontal =>
      EdgeInsets.symmetric(horizontal: highValue);
}
extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
}
