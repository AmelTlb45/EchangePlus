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
    // This can be replaced with actual navigation or dialog for terms and conditions
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

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({super.key});

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: _isChecked,
      onChanged: _onCheckboxChanged,
    );
  }

  // Handle checkbox state change
  void _onCheckboxChanged(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
  }
}
