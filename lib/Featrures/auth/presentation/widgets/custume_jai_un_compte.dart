import 'package:echange_plus/core/utils/app_text_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HaveAnAccountWidget extends StatelessWidget {
  const HaveAnAccountWidget(
      {super.key, required this.text1, required this.text2,  this.onTab});
  final String text1, text2;
  final VoidCallback? onTab;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTab ,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: text1,
              style: CustomTextStyles.Open500style16.copyWith(
                color: const Color.fromARGB(
                    255, 83, 83, 83), // Make the sign-in text blue
                decoration: TextDecoration
                    .underline, // Underline to indicate it's clickable
              ), // Add a style for the first text
            ),
            TextSpan(
              text: text2,
              style: CustomTextStyles.Open500style16.copyWith(
                color: const Color.fromARGB(
                    255, 243, 33, 33), // Make the sign-in text blue
                // Underline to indicate it's clickable
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () { 
                  context.go(
                "/signIn");
                  // Handle navigation to sign-in screen
                  print("Navigate to Sign In screen");
                },
            ),
          ],
        ),
      ),
    );
  }
}
