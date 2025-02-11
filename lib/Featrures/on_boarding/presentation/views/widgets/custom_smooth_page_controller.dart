import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSmoothPageIndecator extends StatelessWidget {
  const CustomSmoothPageIndecator({super.key, required this.controller});
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return  SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: ExpandingDotsEffect(
                  activeDotColor: const Color.fromARGB(255, 4, 4, 4),
                  dotHeight: 7,
                  dotWidth: 10,
                ),
              );
  }
}
