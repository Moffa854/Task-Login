import 'package:flutter/material.dart';

import '../../../../Core/Constant/color_app.dart';
import '../../../../Core/Constant/sizes_app.dart';


class CustomTextFormFeild extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final bool? obscureText;
  final TextInputType? textInputType;
  const CustomTextFormFeild({
    super.key,
    required this.hintText,
    this.suffixIcon,
    required this.controller,
    this.obscureText,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType ?? TextInputType.name,
      obscuringCharacter: '*',
      obscureText: obscureText ?? false,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Vaild Inter';
        }
        return null;
      },
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.all(
          sizesApp(context, 18, 25, 30).toDouble(),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
            color: ColorApp.purple,
            fontSize: sizesApp(context, 13, 15, 17).toDouble(),
            fontFamily: 'Poppins Regular'),
        filled: true,
        fillColor: ColorApp.whitePink,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            sizesApp(context, 12, 18, 22).toDouble(),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            sizesApp(context, 12, 18, 22).toDouble(),
          ),
        ),
      ),
    );
  }
}
