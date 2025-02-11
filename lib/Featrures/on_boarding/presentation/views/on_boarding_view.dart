import 'package:echange_plus/Featrures/on_boarding/presentation/views/widgets/on_boarding_widgets_body.dart';
import 'package:echange_plus/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Stack(
          children: [
            Column(
              children: [
                // Ajoutez ici les autres éléments dans le corps de la page
                OnBoardingWidgetBody(),
              ],
            ),
            // Placer le bouton Skip en haut à droite
            Positioned(
              top: 16.0, // Distance du haut
              right: 16.0, // Distance de la droite
              child: ElevatedButton(
                onPressed: () {
                  // Action lorsque le bouton est pressé
                  Navigator.pushReplacementNamed(context, '/home'); // Ex: Aller à la page d'accueil
                },
                style: ButtonStyle(
                  padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent), // Arrière-plan transparent
                  elevation: WidgetStateProperty.all(0), // Pas d'ombre
                  side: WidgetStateProperty.all<BorderSide>(BorderSide(color: Colors.black)), // Bordure noire
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Coins arrondis
                    ),
                  ),
                ),
                child:
                 Text(
                  AppStrings.skip,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.black, // Couleur du texte
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
