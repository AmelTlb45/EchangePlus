import 'package:echange_plus/app/echange_plus_app.dart';
import 'package:echange_plus/core/database/cache/cache_helper.dart';
import 'package:echange_plus/core/functions/check_state_change.dart';
import 'package:echange_plus/core/services/service_locator.dart';
import 'package:echange_plus/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Assure-toi que les bindings Flutter sont correctement initialisés
  WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
   

  // Initialisation de tes services après Firebase
  setupServiceLocator();

  // Initialisation du CacheHelper (si nécessaire)
  await CacheHelper.init();
  checkStateChanges();
  // Lance l'application
  runApp(const Echange_plus());
}


//change 1

