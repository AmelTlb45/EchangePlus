import 'package:echange_plus/Featrures/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:echange_plus/Featrures/auth/presentation/auth_cubit/auth_state.dart';
import 'package:echange_plus/Featrures/auth/presentation/widgets/custom_PasswordField.dart';
import 'package:echange_plus/Featrures/auth/presentation/widgets/custom_text_field.dart';
import 'package:echange_plus/Featrures/auth/presentation/widgets/terms_and_condition.dart';
import 'package:echange_plus/core/functions/custom_toast.dart';
import 'package:echange_plus/core/utils/app_colors.dart';
import 'package:echange_plus/core/utils/app_strings.dart';
import 'package:echange_plus/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomSignUpForm extends StatefulWidget {
  const CustomSignUpForm({super.key});

  @override
  _CustomSignUpFormState createState() => _CustomSignUpFormState();
}

class _CustomSignUpFormState extends State<CustomSignUpForm> {
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SingupLoadingState) {
          // Afficher un indicateur de chargement si nécessaire
        } else if (state is SignupSuccessState) {
          // Récupère l'objet user de l'état
          var user = state.user; // C'est un seul objet, pas une liste

          showToast("User is successfully signed in!");
          print("User Name: ${user.name}"); // Affiche le nom de l'utilisateur
          print(
              "User Email: ${user.email}"); // Affiche l'email de l'utilisateur

          // Naviguer vers la page de connexion après un délai
          
            context.go("/home"); // Utiliser la navigation de go_router pour rediriger
          
        } else if (state is SingupFailerSFailure) {
          showToast(
              state.errorMessage); // Afficher l'erreur si l'inscription échoue
        }
      },
      builder: (context, state) {
        final authCubit = BlocProvider.of<AuthCubit>(context);
        return Form(
          key: authCubit.signupFromKey,
          child: Column(
            children: [
              CustomTextFormField(
                labelText: AppStrings.firstName,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  authCubit.updateFirstName(value);
                },
                initialValue: context.read<AuthCubit>().firstName ?? '',
              ),
              SizedBox(height: 40),
              CustomTextFormField(
                labelText: AppStrings.lastName,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  authCubit.updateLastName(value);
                },
                initialValue: context.read<AuthCubit>().lastName ?? '',
              ),SizedBox(height: 40),
              ////////// ajouter field de role 
              //SizedBox(height: 40),
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
              SizedBox(height: 44),
              TermsAndConditionsWidget(),
              SizedBox(height: 30),
              state is SingupLoadingState
                  ? CircularProgressIndicator(color: AppColors.redColor)
                  : ElevatedButton(
                      onPressed: () {
                        if (authCubit.termsAndConditionCheckBoxValue == true) {
                          if (context.read<AuthCubit>().emailAddress!.isEmpty ||
                              context.read<AuthCubit>().password!.isEmpty ||
                              context.read<AuthCubit>().firstName!.isEmpty ||
                              context.read<AuthCubit>().lastName!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("Veuillez remplir tous les champs.")));
                          } else if (authCubit.signupFromKey.currentState
                                  ?.validate() ??
                              false) {
                            authCubit.SignUpWithEmailAndPassword();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Veuillez remplir correctement tous les champs.")));
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        // Si la case est cochée, la couleur du bouton est rouge, sinon elle est gris rouge.
                        backgroundColor:
                            authCubit.termsAndConditionCheckBoxValue == false
                                ? AppColors.greyRed // Si la case est cochée
                                : Colors.red, // Si la case n'est pas cochée
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text("S'inscrire",
                          style: CustomTextStyles.Open500style20),
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

  // Le constructeur pour initialiser les données de l'utilisateur
  PigeonUserDetails({
    required this.name,
    required this.email,
  });

  // Méthode pour afficher les informations de l'utilisateur
  @override
  String toString() {
    return 'User: $name, Email: $email';
  }
}
