import 'package:echange_plus/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import "package:echange_plus/core/utils/app_text_style.dart";
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    
    delayedNavigate(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Text(
        AppStrings.appTitle,
        style: CustomTextStyles.Echange400style64,
        ) ,
      ),
    );
  }
}
 void delayedNavigate(context) {
     Future.delayed(
      const Duration(seconds: 2),
      (){
        // ignore: use_build_context_synchronously
        context.go("/onboarding");
        //customNavigate(context,"/onboarding");
      },
    );
  }