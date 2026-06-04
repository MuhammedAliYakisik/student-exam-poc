import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


import '../../core/constant/color_constant.dart';
import '../text/custom_text.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color primaryBlue = ColorConstant.instance.secondaryColor;


    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(context, 0, Icons.people_outline, "Öğrenciler", primaryBlue),
              _buildNavItem(context, 1, Icons.more_time_sharp, "Dersler", primaryBlue),
              _buildNavItem(context, 2, Icons.sticky_note_2_outlined, "Notlar", primaryBlue),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, String label, Color activeColor) {
    bool isSelected = currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected ? activeColor.withOpacity(0.1) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? activeColor : Colors.grey[600],
                size: MediaQuery.of(context).size.width * 0.070,
              ),
            ),
            const Gap(4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: CustomText(label,
                color:isSelected ? activeColor : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              isSmall: true,)
            ),
          ],
        ),
      ),
    );
  }
}