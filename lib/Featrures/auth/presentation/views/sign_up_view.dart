import 'package:echange_plus/Featrures/auth/presentation/widgets/custom_sign_up_form.dart';
import 'package:echange_plus/Featrures/auth/presentation/widgets/custume_jai_un_compte.dart';
import 'package:echange_plus/Featrures/auth/presentation/widgets/welcome_text_widget.dart';
import 'package:echange_plus/core/utils/app_strings.dart';
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
                CustomSignUpForm(), // Utilisation directe de CustomSignUpForm
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

