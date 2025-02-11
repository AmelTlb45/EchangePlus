import 'package:flutter/material.dart';
import 'app_colors.dart'; // Assurez-vous d'avoir défini les couleurs dans app_colors.dart.

abstract class CustomTextStyles {
  // Style de texte pour les titres principaux
  static final Pcifico400style64 = TextStyle (
      fontSize: 64 ,
      fontWeight: FontWeight.w400,
      color: AppColors.redColor,
      fontFamily: "Pcifico", // Utilisation de la couleur rouge
    );
  
 static final Open500style24 = TextStyle (
      fontSize: 24 ,
      fontWeight: FontWeight.w300,
      color: const Color.fromARGB(255, 9, 8, 8),
      fontFamily: "OpenSans", // Utilisation de la couleur rouge
    );
  
}
