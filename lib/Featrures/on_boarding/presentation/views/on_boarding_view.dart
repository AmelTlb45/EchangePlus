import 'package:echange_plus/Featrures/on_boarding/presentation/views/widgets/on_boarding_widgets_body.dart';
import 'package:echange_plus/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
final PageController _controller = PageController(initialPage: 0);

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Stack(
          children: [
            PageView(
              controller: _controller,
              children: [
                OnBoardingWidgetBody(
                  controller: _controller,
                  // Add more widgets here as per your onboarding content
                ),
                // More onboarding pages can be added here as needed
              ],
            ),
            // Skip button at the top right
            Positioned(
              top: 16.0,
              right: 16.0,
              child: ElevatedButton(
                onPressed: () {
                   context.go("/signUp");
                          
                },
                
                child: Text(
                  AppStrings.skip,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}