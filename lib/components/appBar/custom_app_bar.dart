import 'package:flutter/material.dart';

import '../../core/constant/color_constant.dart';
import '../text/custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarText;
  final IconData? leadingIcon;
  final VoidCallback? leadingOnPressed;

  const CustomAppBar({
    super.key,
    required this.appBarText,
    this.leadingIcon,
    this.leadingOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: CustomText(
        appBarText,
        fontWeight: FontWeight.bold,
        isTitle: true,
        color: ColorConstant.instance.secondaryColor,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}