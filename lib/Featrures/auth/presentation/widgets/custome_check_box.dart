
import 'package:echange_plus/Featrures/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:echange_plus/Featrures/auth/presentation/auth_cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({super.key});

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    // Utilisation de BlocBuilder pour écouter les changements dans le Cubit
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Checkbox(
          value: context.read<AuthCubit>().termsAndConditionCheckBoxValue ?? false,  // Utilise la valeur du Cubit
          onChanged: (newValue) {
            context.read<AuthCubit>().UpdateTermsAndConditionCheckBox(newValue: newValue); // Met à jour la valeur dans le Cubit
          },
        );
      },
    );
  }
}
