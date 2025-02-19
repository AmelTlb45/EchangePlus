import 'package:echange_plus/Featrures/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:echange_plus/Featrures/auth/presentation/auth_cubit/auth_state.dart';
import 'package:echange_plus/Featrures/auth/presentation/widgets/custom_PasswordField.dart';
import 'package:echange_plus/Featrures/auth/presentation/widgets/custom_text_field.dart';
import 'package:echange_plus/Featrures/auth/presentation/widgets/terms_and_condition.dart';
import 'package:echange_plus/core/utils/app_colors.dart';
import 'package:echange_plus/core/utils/app_strings.dart';
import 'package:echange_plus/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Creating user...")));
        } else if (state is SignupSuccessState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("User is signed in!")));
        } else if (state is SingupFailerSFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed: ${state.errorMessage}")));
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
              ),
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
              SizedBox(height: 44),
              TermsAndConditionsWidget(),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (authCubit.termsAndConditionCheckBoxValue == true) {
                    if (context.read<AuthCubit>().emailAddress!.isEmpty ||
                        context.read<AuthCubit>().password!.isEmpty ||
                        context.read<AuthCubit>().firstName!.isEmpty ||
                        context.read<AuthCubit>().lastName!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Veuillez remplir tous les champs.")));
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
                          ?AppColors.greyRed// Si la case est cochée
                          :Colors.red, // Si la case n'est pas cochée
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: state is SingupLoadingState
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("S'inscrire",
                        style: CustomTextStyles.Open500style20),
              ),
            ],
          ),
        );
      },
    );
  }
}
