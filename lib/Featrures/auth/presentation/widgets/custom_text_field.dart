import 'package:echange_plus/core/utils/app_strings.dart';
import 'package:echange_plus/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.obscureText = false,
    required this.keyboardType,
    this.onChanged,
    this.onFieldSubmitted,
    required this.initialValue,
  });

  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String initialValue;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      validator: (value) {
        // Validation pour le nom et prénom
        if (labelText == AppStrings.firstName ||
            labelText == AppStrings.lastName) {
          if (value == null || value.isEmpty) {
            return 'Le $labelText ne peut pas être vide';
          } else if (!RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
            return 'Le $labelText ne doit contenir que des lettres';
          }
        }

        // Validation pour l'email
        if (labelText == AppStrings.emailAddress) {
          if (value == null || value.isEmpty) {
            return 'L\'email ne peut pas être vide';
          } else if (!RegExp(
                  r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
              .hasMatch(value)) {
            return 'L\'email n\'est pas valide';
          }
        }

        // Si la validation passe
        return null;
      },
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(
              value); // Appelle la fonction onChanged passée en paramètre
        }
      },
      onFieldSubmitted: (value) {
        if (onFieldSubmitted != null) {
          onFieldSubmitted!(
              value); // Appelle la fonction onFieldSubmitted si définie
        }
      },
      obscureText: obscureText,
      keyboardType: keyboardType,
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
