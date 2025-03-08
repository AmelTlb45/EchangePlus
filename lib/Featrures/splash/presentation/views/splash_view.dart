import 'package:echange_plus/core/database/cache/cache_helper.dart';
 import 'package:echange_plus/core/utils/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:echange_plus/core/utils/app_text_style.dart";
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    bool isOnBoardingVisited =
        CacheHelper.getData(key: "isOnBoardingVisited") ?? false;

    // Vérifie si l'onboarding a déjà été visité
    if (isOnBoardingVisited == true) {
     FirebaseAuth.instance.currentUser == null 
      ?  delayedNavigate("/signUp")
      :  FirebaseAuth.instance.currentUser!.emailVerified==true? 
      delayedNavigate("/home")
      :delayedNavigate("/signIn"); 
       // Navigue vers signUp si déjà visité
    } else {
      delayedNavigate("/onboarding");  // Navigue vers onboarding si pas visité
    }
  }

  void delayedNavigate(String path) {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (mounted) { // Vérifie si le widget est toujours dans l'arbre
          context.go(path);  // Utilise le bon chemin
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          AppStrings.appTitle,
          style: CustomTextStyles.Pcifico400style64,
        ),
      ),
    );
  }
}
