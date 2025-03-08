import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ForgotPasswordImage extends StatelessWidget {
  const ForgotPasswordImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/16.svg', // Remplacez ce chemin par le bon chemin de ton SVG
      width: 150, 
      height: 150, 
    );
  }
}
