import 'package:echange_plus/core/database/cache/cache_helper.dart';
import 'package:echange_plus/core/routes/app_router.dart';
import 'package:echange_plus/core/services/service_locator.dart';
import 'package:echange_plus/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await CacheHelper.init();
  runApp(const MyWidget());
}
//change 1

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255)
        
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
     
    );
  }
}
