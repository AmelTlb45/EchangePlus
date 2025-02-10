import 'package:echange_plus/core/routes/app_router.dart';
import 'package:echange_plus/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';



void main() async {

  runApp(const MyWidget());
}
//change 1

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.redColor
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
     
    );
  }
}
