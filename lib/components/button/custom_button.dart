import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../core/constant/color_constant.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;


  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.height = 54,
  });

  @override
  Widget build(BuildContext context) {

    final finalBgColor = backgroundColor ?? ColorConstant.instance.secondaryColor;
    final finalTextColor = textColor ?? Colors.white;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: finalBgColor,
          foregroundColor: finalTextColor,
          elevation: 4,
          shadowColor: finalBgColor.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            color: finalTextColor,
            strokeWidth: 2,
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20, color: finalTextColor),
              const Gap(10),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                color: finalTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}