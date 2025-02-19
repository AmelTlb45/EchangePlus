import 'package:echange_plus/Featrures/auth/presentation/widgets/custome_check_box.dart';
import 'package:flutter/material.dart';
import 'package:echange_plus/core/utils/app_text_style.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  const TermsAndConditionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Checkbox widget
        const CustomCheckbox(),
        const SizedBox(width: 6),
        // Clickable terms text
        Expanded(
          child: GestureDetector(
            onTap: () {
              _openTermsAndConditions(context);
            },
            child: Text(
              'J\'accepte vos termes et conditions',
              style: CustomTextStyles.Open500style12.copyWith(
                color: const Color.fromARGB(255, 0, 0, 0), // Make the text blue for clarity
                decoration: TextDecoration.underline, // Underline the text for clickable effect
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Navigate to terms and conditions page or display them in a dialog
  void _openTermsAndConditions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Terms and Conditions"),
        content: const SingleChildScrollView(
          child: Text(
            "Here are the terms and conditions...",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close the dialog
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}
