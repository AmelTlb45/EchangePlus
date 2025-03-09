import 'package:echange_plus/Featrures/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:echange_plus/Featrures/auth/presentation/auth_cubit/auth_state.dart';
import 'package:echange_plus/Featrures/auth/presentation/widgets/custom_PasswordField.dart';
import 'package:echange_plus/Featrures/auth/presentation/widgets/custom_text_field.dart';
import 'package:echange_plus/Featrures/auth/presentation/widgets/terms_and_condition.dart';
import 'package:echange_plus/core/functions/custom_toast.dart';
import 'package:echange_plus/core/utils/app_colors.dart';
import 'package:echange_plus/core/utils/app_strings.dart';
import 'package:echange_plus/core/utils/app_text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomSignInForm extends StatefulWidget {
  const CustomSignInForm({super.key});

  @override
  _CustomSignInFormState createState() => _CustomSignInFormState();
}

class _CustomSignInFormState extends State<CustomSignInForm> {
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignInLoadingState) {
          // Afficher un indicateur de chargement si nécessaire
        } else if (state is SignInSuccessState) {
          showToast("Bonjour encore !!!");
          
           FirebaseAuth.instance.currentUser!.emailVerified?
          context.go("/home"):
          showToast("svp vérifier ton compte !");
        } else if (state is SingInFailerSFailure) {
          // Affiche l'erreur si la connexion échoue
          showToast(state.errorMessage);
        }
      },
      builder: (context, state) {
        final authCubit = BlocProvider.of<AuthCubit>(context);
        return Form(
          key: authCubit.signinFromKey,
          child: Column(
            children: [
              SizedBox(height: 40),
              CustomTextFormField(
                labelText: AppStrings.emailAddress,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  authCubit.updateEmail(value);
                },
                initialValue: context.read<AuthCubit>().emailAddress ?? '',
              ),
              SizedBox(height: 40),
              PasswordField(
                labelText: AppStrings.password,
                onChanged: (value) {
                  authCubit.updatePassword(value);
                },
                initialValue: context.read<AuthCubit>().password ?? '',
              ),
              const SizedBox(height: 30),
              state is SingupLoadingState
                  ? CircularProgressIndicator(color: AppColors.redColor)
                  : ElevatedButton(
                      onPressed: () async{
                        if (authCubit.signinFromKey.currentState?.validate() ??
                            false) {
                        await  authCubit.signInWithEmailAndPassword();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        // Si la case est cochée, la couleur du bouton est rouge, sinon elle est gris rouge.
                        backgroundColor:
                            Colors.red, // Si la case n'est pas cochée
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text("Se Connecter",
                          style: CustomTextStyles.Open500style20),
                    ),
              const SizedBox(height: 20),
              // Ajouter le lien "Mot de passe oublié"
              TextButton(
                onPressed: () {
                  // Logique pour gérer l'oubli du mot de passe
                  // Par exemple, rediriger vers la page de réinitialisation du mot de passe
                  context.go("/forgotPassword");
                },
                child: Text(
                  "Mot de passe oublié ?",
                  style: CustomTextStyles.Open500style16.copyWith(
                    color: const Color.fromARGB(
                        255, 252, 147, 41), // Style avec couleur rouge
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PigeonUserDetails {
  final String name; // Le nom de l'utilisateur
  final String email; // L'email de l'utilisateur
  final String role; // Ajout du champ `role` (admin ou user)

  // Le constructeur pour initialiser les données de l'utilisateur, y compris le rôle
  PigeonUserDetails({
    required this.name,
    required this.email,
    required this.role, // Ajout du rôle
  });

  // Méthode pour afficher les informations de l'utilisateur
  @override
  String toString() {
    return 'User: $name, Email: $email, Role: $role'; // Affichage du rôle
  }
}
