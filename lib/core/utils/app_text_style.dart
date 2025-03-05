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
    static final Pcifico400style42 = TextStyle (
      fontSize: 42 ,
      fontWeight: FontWeight.w400,
      color: AppColors.redColor,
      fontFamily: "Pcifico", // Utilisation de la couleur rouge
    );
    static final Pcifico400style50 = TextStyle (
      fontSize: 50 ,
      fontWeight: FontWeight.w400,
      color:  const Color.fromARGB(255, 0, 0, 0),
      fontFamily: "Pcifico", // Utilisation de la couleur rouge
    );
  
 static final Open500style24 = TextStyle (
      fontSize: 24 ,
      fontWeight: FontWeight.bold,
      color: const Color.fromARGB(255, 251, 249, 249),
      fontFamily: "OpenSans",
      // Utilisation de la couleur rouge
    );
  static final Open500style12 = TextStyle (
      fontSize: 12 ,
      fontWeight: FontWeight.bold,
      color: const Color.fromARGB(255, 106, 106, 106),
      fontFamily: "OpenSans",
      // Utilisation de la couleur rouge
    );

    
    static final Open500style16 = TextStyle (
      fontSize: 16 ,
      fontWeight: FontWeight.bold,
      color: const Color.fromARGB(255, 255, 255, 255),
      fontFamily: "OpenSans",
      // Utilisation de la couleur rouge
    );
    static final Open500style20 = TextStyle (
      fontSize: 20 ,
      fontWeight: FontWeight.bold,
      color: const Color.fromARGB(255, 255, 255, 255),
      fontFamily: "OpenSans",
      // Utilisation de la couleur rouge
    );

}
