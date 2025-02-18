import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

// Définir les événements possibles de l'authentification
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());  // L'état initial est AuthInitial

  // Méthode pour démarrer le processus de connexion
  void signIn(String email, String password) {
    emit(AuthLoading());  // Changer l'état en AuthLoading pendant le traitement

    // Simuler une logique d'authentification (remplace par ta logique réelle)
    Future.delayed(Duration(seconds: 2), () {
      if (email == "user@example.com" && password == "password") {
        emit(AuthSuccess());  // L'authentification réussie
      } else {
        emit(AuthFailure("Email ou mot de passe incorrect"));  // Erreur d'authentification
      }
    });
  }

  // Méthode pour démarrer le processus d'inscription
  void signUp(String email, String password) {
    emit(AuthLoading());

    // Simuler le processus d'inscription
    Future.delayed(Duration(seconds: 2), () {
      emit(AuthSuccess());  // Inscription réussie
    });
  }

  // Méthode pour déconnecter l'utilisateur
  void signOut() {
    emit(AuthInitial());  // Réinitialiser l'état à l'état initial
  }
}
