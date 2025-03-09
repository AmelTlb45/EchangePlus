import 'package:echange_plus/Featrures/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:echange_plus/Featrures/auth/presentation/auth_cubit/auth_state.dart';
import 'package:echange_plus/core/functions/custom_toast.dart';
import 'package:echange_plus/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:echange_plus/core/utils/app_colors.dart';
import 'package:echange_plus/core/utils/app_text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomForgotPasswordForm extends StatelessWidget {
  CustomForgotPasswordForm({super.key});

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccessState) {
          // Show the success dialog when password reset is successful
           showToast("Vérifiez votre email pour réinitialiser votre mot de passe");
           context.go("/signIn");
        } else if (state is ResetPasswordFailerSFailure) {
          // Optionally, show a failure dialog or toast
          showToast(state.errorMessage);
        }
      },
      builder: (context, state) {
        final authCubit = BlocProvider.of<AuthCubit>(context);
        return Form(
          key: authCubit.forgotPasswordFromKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Title
                Text(
                  'Réinitialisation',
                  style: CustomTextStyles.Pcifico400style50,
                ),
                const SizedBox(height: 10),
                Text(
                  'du mot de passe',
                  style: CustomTextStyles.Pcifico400style42,
                ),
                const SizedBox(height: 30),
                Text(
                  'Entrez votre email pour recevoir\nun lien de réinitialisation',
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.Open500style16.copyWith(
                    color: AppColors.greyRed,
                    fontWeight: FontWeight.normal,
                  ),
                ),

                const SizedBox(height: 40),

                // Email field
                TextFormField(
                  style: CustomTextStyles.Open500style16.copyWith(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 245, 245, 245),
                    labelText: AppStrings.emailAddress, // Assuming AppStrings is a string file for localization
                    labelStyle: CustomTextStyles.Open500style12.copyWith(
                      color: Colors.black,
                    ),
                    prefixIcon: Icon(Icons.email, color: AppColors.redColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColors.redColor,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 255, 255, 255),
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    // Update email in the cubit
                    context.read<AuthCubit>().updateEmail(value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une adresse email';
                    }
                    // Check for a valid email format
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Format email invalide';
                    }
                    return null; // No error
                  },
                  initialValue: context.read<AuthCubit>().emailAddress ?? '',
                ),

                const SizedBox(height: 30),

                // Submit button with loading state
                SizedBox(
                  width: double.infinity,
                  child: state is ResetPasswordLoadingState
                      ? CircularProgressIndicator(color: AppColors.redColor)
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.redColor,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            if (authCubit.forgotPasswordFromKey.currentState?.validate() ?? false) {
                              authCubit.ResetPasswordWithLink(); // Trigger password reset
                            }
                          },
                          child: Text(
                            'Envoyer le lien',
                            style: CustomTextStyles.Open500style20,
                          ),
                        ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => context.go("/signIn"),
                  child: Text(
                    'Retour à la connexion',
                    style: CustomTextStyles.Open500style12.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Show success dialog
  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Succès !', style: CustomTextStyles.Pcifico400style64),
        content: Text(
          'Vérifiez votre boîte mail pour le lien de réinitialisation',
          style: CustomTextStyles.Open500style16,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go("/signIn");
            },
            child: Text('OK', style: CustomTextStyles.Open500style16),
          ),
        ],
      ),
    );
  }

  // Show error dialog
  void _showErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Erreur', style: CustomTextStyles.Pcifico400style64),
        content: Text(
          error,
          style: CustomTextStyles.Open500style16,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK', style: CustomTextStyles.Open500style16),
          ),
        ],
      ),
    );
  }
}
