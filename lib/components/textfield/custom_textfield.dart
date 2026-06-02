import 'package:flutter/material.dart';
import 'package:studen_exam_poc/core/extension/context_extension.dart';
import 'package:studen_exam_poc/core/extension/size_extension.dart';

import '../../core/constant/color_constant.dart';

class CustomTextField extends StatefulWidget {
  final String? label;
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Function(String)? onChanged;


  const CustomTextField({
    super.key,
    this.label,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null && widget.label!.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: context.veryLowValue, bottom: context.lowValue),
            child: Text(
              widget.label!.toUpperCase(),
              style: context.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorConstant.instance.textFieldLabelColor,
                letterSpacing: 1.1,
              ),
            ),
          ),

        Container(
          decoration: BoxDecoration(
            color: ColorConstant.instance.textFieldBackgroundColor,
            borderRadius: BorderRadius.circular(context.lowValue),
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: _obscureText,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            style: context.textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: widget.hintText,
              prefixIcon: Icon(
                widget.prefixIcon,
                color: ColorConstant.instance.textFieldContentColor,
                size: context.responsiveIconSize(0.06),
              ),
              hintStyle: context.textTheme.bodyMedium?.copyWith(
                color: ColorConstant.instance.textFieldContentColor,
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  size: context.responsiveIconSize(0.05),color: ColorConstant.instance.textFieldContentColor,
                ),
                onPressed: () => setState(() => _obscureText = !_obscureText),
              )
                  : null,
              border: InputBorder.none,

              contentPadding: context.paddingNormal,
            ),
          ),
        ),


        SizedBox(height: context.lowValue),
      ],
    );
  }
}