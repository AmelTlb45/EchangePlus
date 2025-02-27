import 'package:echange_plus/core/utils/app_colors.dart';
import 'package:echange_plus/core/utils/app_strings.dart';
import 'package:echange_plus/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
 // Assurez-vous d'avoir défini les couleurs dans app_colors.dart.
import 'package:go_router/go_router.dart';
 // Importation des styles personnalisés.

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  // Méthode pour naviguer vers l'inscription
  void _navigateToSignUp(BuildContext context) {
    context.go("/signUp");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Espacement autour du contenu
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Texte de bienvenue avec un style personnalisé
              Text(
                'Bienvenue sur l\'application', 
                style: CustomTextStyles.Pcifico400style64, // Utilisation du style Pcifico400style64
              ),
              const SizedBox(height: 20), 
              // Bouton de connexion
              ElevatedButton(
                onPressed: () {
                  // Logique de connexion ici
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.redColor, // Utilisation de la couleur principale pour le bouton
                ),
                child: Text(
                  "Se connecter",
                  style: CustomTextStyles.Open500style20, // Utilisation du style Open500style20
                ),
              ),
              const SizedBox(height: 20), 
              // Texte pour rediriger vers l'inscription
              TextButton(
                onPressed: () => _navigateToSignUp(context),
                child: Text(
                  'Pas encore inscrit ? Créer un compte',
                  style: CustomTextStyles.Open500style12, // Utilisation du style Open500style12
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
