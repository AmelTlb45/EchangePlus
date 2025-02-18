import 'package:echange_plus/core/database/cache/cache_helper.dart';
import 'package:echange_plus/core/routes/app_router.dart';
import 'package:echange_plus/core/services/service_locator.dart';
import 'package:echange_plus/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Assure-toi que les bindings Flutter sont correctement initialisés
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialisation de Firebase avec les options spécifiques à la plateforme
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialisé avec succès");
  } catch (e) {
    // Capture les erreurs d'initialisation de Firebase
    print('Erreur d\'initialisation de Firebase: $e');
  }

  // Initialisation de tes services après Firebase
  setupServiceLocator();

  // Initialisation du CacheHelper (si nécessaire)
  await CacheHelper.init();

  // Lance l'application
  runApp(const MyWidget());
}

//change 1

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255)),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
