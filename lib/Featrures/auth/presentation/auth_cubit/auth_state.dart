// Définir les états d'authentification
abstract class AuthState {}

class AuthInitial extends AuthState {}  // État initial (avant que l'utilisateur ne se connecte ou s'inscrive)

class AuthLoading extends AuthState {}  // L'authentification ou l'inscription est en cours

class AuthSuccess extends AuthState {}  // L'authentification ou l'inscription est réussie

class AuthFailure extends AuthState {
  final String errorMessage;  // Message d'erreur en cas de problème
  AuthFailure(this.errorMessage);
}
