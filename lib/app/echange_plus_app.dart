import 'package:echange_plus/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Si tu utilises BlocProvider
import 'package:provider/provider.dart'; // Importer MultiProvider

import 'package:echange_plus/Featrures/auth/presentation/auth_cubit/auth_cubit.dart';
// Pour BlocProvider

class Echange_plus extends StatelessWidget {
  const Echange_plus({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<AuthCubit>(
            create: (context) => AuthCubit()), // Fournir AuthCubit ici
        // Ajouter d'autres providers si nécessaire
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: router, // Assurez-vous que router est bien configuré
      ),
    );
  }
}
