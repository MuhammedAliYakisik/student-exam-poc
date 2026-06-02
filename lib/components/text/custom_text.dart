import 'package:flutter/material.dart';
import 'package:studen_exam_poc/core/extension/context_extension.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final bool isTitle;
  final bool isSmall;

  const CustomText(
      this.text, {
        super.key,
        this.color,
        this.fontWeight,
        this.textAlign,
        this.isTitle = false,
        this.isSmall = false,
      });

  @override
  Widget build(BuildContext context) {
    TextStyle? style;

    if (isTitle) {
      style = context.textTheme.titleLarge;
    } else if (isSmall) {
      style = context.textTheme.labelSmall;
    } else {
      style = context.textTheme.titleSmall;
    }

    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      style: style?.copyWith(
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.normal,

        height: isSmall ? 1.2 : null,
      ),
    );
  }
}