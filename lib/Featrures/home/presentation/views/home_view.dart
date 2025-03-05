import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:echange_plus/Featrures/auth/presentation/auth_cubit/auth_cubit.dart'; // Ton AuthCubit

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: FutureBuilder<String>(
        future: context.read<AuthCubit>().getUserRole(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            String userRole = snapshot.data!;
            // Utiliser post-frame callback pour exécuter le routage après la construction du widget
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (userRole == 'admin') {
                context.go('/admin'); // Rediriger vers la page Admin
              } else {
                context.go('/user'); // Rediriger vers la page User
              }
            });
            return SizedBox
                .shrink(); // Retourner un widget vide pendant la redirection
          }

          return Center(child: Text('Erreur de récupération du rôle'));
        },
      ),
    );
  }
}
