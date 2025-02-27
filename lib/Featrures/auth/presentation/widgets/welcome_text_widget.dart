import 'package:echange_plus/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class WelcomeTextWidget extends StatelessWidget {
  const WelcomeTextWidget({super.key,required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Align(
      child:Text(
        text, 
        style: CustomTextStyles.Pcifico400style50,)
        );
  }
}