
import 'package:echange_plus/core/routes/app_router.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Echange_plus extends StatelessWidget {
  const Echange_plus({super.key});

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