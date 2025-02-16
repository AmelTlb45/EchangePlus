import 'package:echange_plus/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.labelText, this.obscureText = false, required TextInputType keyboardType});

  final String labelText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelStyle: CustomTextStyles.Open500style12,
        labelText: labelText,
        border: getBorderStyle(),
        enabledBorder: getBorderStyle(),
        focusedBorder: getBorderStyle(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }
}

OutlineInputBorder getBorderStyle() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.grey),
  );
}
