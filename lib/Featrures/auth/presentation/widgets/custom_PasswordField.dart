import 'package:echange_plus/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final String labelText;
  final Function(String) onChanged; // Fonction de mise à jour de la valeur du mot de passe

  const PasswordField({super.key, required this.labelText, required this.onChanged, required String initialValue});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  String _password = ""; // Variable pour stocker le mot de passe

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le mot de passe ne peut pas être vide';
    }
    // Validation de la longueur du mot de passe
    if (value.length < 8) {
      return 'Le mot de passe doit contenir au moins 8 caractères';
    }
    // Validation pour un caractère spécial
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Le mot de passe doit contenir au moins un caractère spécial';
    }
    // Validation pour un chiffre
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Le mot de passe doit contenir au moins un chiffre';
    }
    // Validation pour une lettre majuscule
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Le mot de passe doit contenir au moins une lettre majuscule';
    }
    // Validation pour une lettre minuscule
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Le mot de passe doit contenir au moins une lettre minuscule';
    }
    return null; // Le mot de passe est valide
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:_passwordValidator,
      obscureText: _obscureText,
      onChanged: (value) {
        setState(() {
          _password = value; // Met à jour le mot de passe local
        });
        widget.onChanged(value); // Appelle la fonction onChanged pour mettre à jour le mot de passe
      },
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
