import 'package:flutter/material.dart';

Widget myTextField({
  hintText,
  required controller,
  Color? fillColor,
  Color? textColor,
  Color? hintTextColor,
  bool obscureText = false,
  Widget? suffixIcon,
  Widget? prefixIcon,
}) {
  return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: textColor), // This controls input text color
      decoration: InputDecoration(
          hintText: hintText,
          fillColor: fillColor ?? Colors.transparent,
          hintStyle:
              TextStyle(color: hintTextColor), // This controls hint text color

          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(borderSide: BorderSide())));
}
