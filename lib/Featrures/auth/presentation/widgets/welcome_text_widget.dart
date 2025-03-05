import 'package:echange_plus/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:echange_plus/core/utils/app_colors.dart'; // Assurez-vous que AppColors est bien importé

class WelcomeTextWidget extends StatelessWidget {
  const WelcomeTextWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center, // Centrer le texte
      child: Text(
        text,
        style: CustomTextStyles.Pcifico400style50.copyWith(
          color: AppColors.redColor, // Applique la couleur rouge au texte
        ),
        textAlign: TextAlign.center, // Centre le texte
      ),
    );
  }
}
