import 'package:flutter/material.dart';
import '../../core/constant/color_constant.dart';
import '../../core/extension/context_extension.dart';
import '../../core/extension/size_extension.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final String hintText;
  final IconData prefixIcon;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.hintText,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: context.lowValue),
          decoration: BoxDecoration(
            color: ColorConstant.instance.textFieldBackgroundColor,
            borderRadius: BorderRadius.circular(context.lowValue),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: ColorConstant.instance.textFieldContentColor,
              ),
              hint: Row(
                children: [
                  Icon(
                    prefixIcon,
                    color: ColorConstant.instance.textFieldContentColor,
                    size: context.responsiveIconSize(0.06),
                  ),
                  SizedBox(width: context.lowValue),
                  Text(
                    hintText,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: ColorConstant.instance.textFieldContentColor,
                    ),
                  ),
                ],
              ),
              items: items,
              onChanged: onChanged,
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(context.lowValue),
              style: context.textTheme.bodyMedium,
            ),
          ),
        ),
        SizedBox(height: context.lowValue),
      ],
    );
  }
}