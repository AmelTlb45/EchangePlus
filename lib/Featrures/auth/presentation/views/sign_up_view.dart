import 'package:echange_plus/Featrures/auth/presentation/widgets/custom_PasswordField.dart';
import 'package:echange_plus/Featrures/auth/presentation/widgets/custom_text_field.dart';
import 'package:echange_plus/Featrures/auth/presentation/widgets/custume_jai_un_compte.dart';
import 'package:echange_plus/Featrures/auth/presentation/widgets/terms_and_condition.dart';
import 'package:echange_plus/Featrures/auth/presentation/widgets/welcome_text_widget.dart';
import 'package:echange_plus/core/utils/app_strings.dart';
import 'package:echange_plus/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Permet de rendre la page scrollable
        child: Center(
          // Centre tout le contenu de la page
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 24), // Espacement autour du contenu
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centre verticalement
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Centre horizontalement
              children: [
                SizedBox(height: 130), // Espacement avant le texte "Welcome"
                WelcomeTextWidget(text: AppStrings.b),
                SizedBox(height: 20),
                CustomTextField(
                  labelText: "Prénom",
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 40),
                CustomTextField(
                  labelText: "Nom",
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 40),
                CustomTextField(
                  labelText: "E-mail",
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 40),
                PasswordField(labelText: "Mot de passe"),
                SizedBox(height: 44),
                TermsAndConditionsWidget(),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // Action à exécuter lors de l'inscription
                    print("Inscription validée !");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 226, 50, 50),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "S'inscrire",
                    style: CustomTextStyles.Open500style16,
                  ),
                ),
                SizedBox(height: 80),
                HaveAnAccountWidget(
                  text1: "J'ai déjà un compte ",
                  text2: AppStrings.signIn,
                ),
                SizedBox(
                    height:
                        20), // Espacement sous le texte "J'ai déjà un compte"
              ],
            ),
          ),
        ),
      ),
    );
  }
}
