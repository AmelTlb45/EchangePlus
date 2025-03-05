import 'package:echange_plus/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final String labelText;
  final Function(String)
      onChanged; // Fonction de mise à jour de la valeur du mot de passe
  final String initialValue;

  const PasswordField({
    super.key,
    required this.labelText,
    required this.onChanged,
    required this.initialValue,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  // Fonction de validation pour le mot de passe
  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le mot de passe ne peut pas être vide';
    }
    if (value.length < 8) {
      return 'Le mot de passe doit contenir au moins 8 caractères';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Le mot de passe doit contenir au moins un caractère spécial';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Le mot de passe doit contenir au moins un chiffre';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Le mot de passe doit contenir au moins une lettre majuscule';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Le mot de passe doit contenir au moins une lettre minuscule';
    }
    return null; // Mot de passe valide
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue:
          widget.initialValue, // Initialisation avec la valeur du mot de passe
      validator: _passwordValidator, // Validation du mot de passe
      obscureText: _obscureText, // Masquer ou afficher le mot de passe
      onChanged: (value) {
        widget.onChanged(value); // Appel de la fonction onChanged
      },
      decoration: InputDecoration(
        labelStyle: CustomTextStyles.Open500style12,
        labelText: widget.labelText, // Texte du label
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12), // Coins arrondis comme le champ Email
          borderSide: BorderSide(color: Colors.grey), // Bordure grise légère
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Coins arrondis
          borderSide: BorderSide(color: Colors.grey), // Bordure grise
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Coins arrondis
          borderSide: BorderSide(
              color: Colors.grey), // Bordure grise quand le champ est focus
        ),
        suffixIcon: IconButton(
          icon: Icon(_obscureText
              ? Icons.visibility
              : Icons.visibility_off), // Affiche ou cache l'icône
          onPressed: () {
            setState(() {
              _obscureText =
                  !_obscureText; // Bascule l'état d'affichage du mot de passe
            });
          },
        ),
      ),
    );
  }
}
