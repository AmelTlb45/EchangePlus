import 'package:echange_plus/Featrures/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:echange_plus/Featrures/auth/presentation/views/forgot_Password_view.dart';
import 'package:echange_plus/Featrures/auth/presentation/views/sign_In_view.dart';
import 'package:echange_plus/Featrures/auth/presentation/views/sign_up_view.dart';
import 'package:echange_plus/Featrures/home/presentation/views/home_view.dart';
import 'package:echange_plus/Featrures/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:echange_plus/Featrures/splash/presentation/views/splash_view.dart';
import 'package:echange_plus/core/members/Admin/admin_page.dart';
import 'package:echange_plus/core/members/User/profil/profil_edit.dart';
import 'package:echange_plus/core/members/User/profil/profil_show.dart';
import 'package:echange_plus/core/members/User/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => SplashView(),
  ),
  GoRoute(
    path: "/OnBoarding",
    builder: (context, state) => OnBoardingView(),
  ),
  GoRoute(
    path: "/signUp",
    builder: (context, state) => BlocProvider(
      create: (context) => AuthCubit(),
      child: SignUpView(),
    ),
  ),
  // GoRoute(path:"/signIn",
  //builder: (context, state) => BlocProvider(
  //  create:(context) => getIt<AuthCubit>(),
  //  child: SignInView(),
  //),
  //),

  GoRoute(
    path: '/signIn',
    builder: (context, state) {
      return BlocProvider(
        create: (context) => AuthCubit(),
        child: SignInView(), // Page de connexion
      );
    },
  ),

  GoRoute(
    path: "/home",
    builder: (context, state) => HomeView(),
  ),

  GoRoute(
    path: '/user',
    builder: (context, state) {
      return UserPage(); // Page réservée aux utilisateurs
    },
  ),
  GoRoute(
    path: '/admin',
    builder: (context, state) {
      return AdminPage(); // Page réservée aux admins
    },
  ),
  
   GoRoute(
    path: '/forgotPassword',
    builder: (context, state) {
      return BlocProvider(
        create: (context) => AuthCubit(),
        child: ForgotPasswordView(), // Page de connexion
      );
    },
  ),

  GoRoute(
  path: '/profile',
  builder: (context, state) {
    // Récupérer l'argument passé avec 'extra' de manière sûre
    final Position? userPosition = state.extra as Position?;

    if (userPosition == null) {
      // Gérer le cas où la position de l'utilisateur est nulle
      return Scaffold(
        body: Center(child: Text("La position de l'utilisateur est introuvable.")),
      );
    }

    return ProfilePage(userPosition: userPosition); // Passer la position à la page ProfilePage
  },
),

GoRoute(
      path: '/profil_edit',
      builder: (context, state) {
        final userPosition = state.extra as Position?;
        return ProfileEditPage(userPosition: userPosition!); // ProfileEditPage
      },
    ),





]);
