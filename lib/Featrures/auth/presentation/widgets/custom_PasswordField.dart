
import 'package:echange_plus/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final String labelText;
  const PasswordField({super.key, required this.labelText});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelStyle: CustomTextStyles.Open500style12,
        labelText: widget.labelText,
        border: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
  ),
        enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
  ),
        focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
  ),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}