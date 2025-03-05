import 'package:echange_plus/Featrures/auth/presentation/widgets/custom_sign_in.dart';
import 'package:echange_plus/Featrures/auth/presentation/widgets/custume_jai_un_compte.dart';
import 'package:echange_plus/core/utils/app_colors.dart';
import 'package:echange_plus/core/utils/app_strings.dart';
import 'package:echange_plus/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  // Méthode pour naviguer vers l'inscription
  void _navigateToSignUp(BuildContext context) {
    context.go("/signUp");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sliver pour l'introduction
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Centrer l'image
                  const SizedBox(height: 100),
                  Center(
                    child: Image.asset(
                      "assets/images/auth.png", // Affichage de l'image auth.png
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 100),
                  Text(
                    "Se Connecter",
                    style: CustomTextStyles
                        .Pcifico400style42, // Réduire la taille du texte
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // Sliver pour le formulaire de connexion
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // Formulaire de connexion avec CustomSignInForm
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: CustomSignInForm(),
                ),
                const SizedBox(height: 10),
                // Lien vers l'inscription avec couleur orange-jaune uniquement pour "Créer un compte"
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextButton(
                    onPressed: () => _navigateToSignUp(
                        context), // Action de navigation vers l'inscription
                    child: RichText(
                      text: TextSpan(
                        style: CustomTextStyles.Open500style16.copyWith(
                          color: Colors.black, // Texte par défaut en noir
                        ),
                        children: [
                          TextSpan(
                            text: 'Pas encore inscrit ? ', // Texte normal
                          ),
                          TextSpan(
                            text: 'Créer un compte', // Texte stylisé
                            style: TextStyle(
                                color: const Color.fromARGB(255, 255, 64, 64)), // Couleur orange-jaune
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),


        
// SILVERS
        ],
      ),
    );
  }
}
