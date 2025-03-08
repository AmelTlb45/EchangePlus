import 'package:echange_plus/Featrures/auth/presentation/widgets/custom_forgot_pass.dart';
import 'package:echange_plus/Featrures/auth/presentation/widgets/forgot_pass_image.dart';
import 'package:flutter/material.dart';
import 'package:custom_will_pop_scope/custom_will_pop_scope.dart';  // Importer CustomWillPopScope

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomWillPopScope(  // Utilisation de CustomWillPopScope
        onWillPop: () async {
          bool shouldPop = await _onBackPressed(context);  // Gérer la logique du bouton de retour physique
          return shouldPop;
        },
        child: CustomScrollView(
          slivers: [
            // Sliver pour un espace avant l'image
            SliverToBoxAdapter(
              child: SizedBox(height: 108),  // Espace au-dessus de l'image
            ),
            
            // Sliver pour afficher l'image SVG
            SliverToBoxAdapter(
              child: ForgotPasswordImage(),  // Affichage de l'image SVG
            ),
            
            // Espace entre l'image et le contenu suivant
            SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            
            // Sliver pour ajouter un espace avant le formulaire
            SliverToBoxAdapter(
              child: CustomForgotPasswordForm(),  // Appel du formulaire
            ),
          ],
        ),
      ),
    );
  }

  // Méthode pour gérer l'événement du bouton retour physique
  Future<bool> _onBackPressed(BuildContext context) async {
    bool shouldExit = await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Confirmer'),
        content: Text('Êtes-vous sûr de vouloir quitter sans sauvegarder ?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false); // Ne pas quitter
            },
            child: Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true); // Permet de revenir à la page précédente
              Navigator.of(context).pop();  // Retourne à la page précédente dans la pile de navigation
            },
            child: Text('Quitter'),
          ),
        ],
      ),
    );

    return shouldExit;  // Retourne false si la valeur est nulle
  }
}
