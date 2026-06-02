import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:studen_exam_poc/core/extension/size_extension.dart';
import '../../core/constant/color_constant.dart';
import '../../core/extension/context_extension.dart';
import '../text/custom_text.dart';

void showCustomSnackBar(BuildContext context, String text,int status) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(
            _getStatusIcon(status),
            color: Colors.white,
            size: context.dynamicHeight(0.03),
          ),
          Gap(context.lowHeightValue),
          Expanded(
            child: CustomText(text,
              color: Colors.white,
              fontWeight: FontWeight.w400
            ),)

        ],
      ),
      backgroundColor: _getStatusColor(status),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
Color _getStatusColor(int status) {
  switch (status) {
    case 0:
      return ColorConstant.instance.errorColor;
    case 1:
      return ColorConstant.instance.warningColor;
    case 2:
      return ColorConstant.instance.succesfullColor;
    default:
      return  ColorConstant.instance.warningColor;
  }
}
IconData _getStatusIcon(int status) {
  switch (status) {
    case 0:
      return Icons.cancel_outlined;
    case 1:
      return Icons.warning_amber;
    case 2:
      return Icons.check_circle_outline;
    default:
      return  Icons.warning_amber;
  }
}


