import 'package:echange_plus/Featrures/auth/presentation/widgets/custom_sign_up_form.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class SingupLoadingState extends AuthState {}

class SignupSuccessState extends AuthState {
  final PigeonUserDetails
      user; // Au lieu d'une liste, on passe un seul utilisateur

  SignupSuccessState(this.user); // Le constructeur prend un PigeonUserDetails
}

class SingupFailerSFailure extends AuthState {
  final String errorMessage;

  SingupFailerSFailure({required this.errorMessage});
}

class TermsAndConditionsUpdateState extends AuthState {}

class SignInLoadingState extends AuthState {}

class SignInSuccessState extends AuthState {
 // Le constructeur prend un PigeonUserDetails
}

class SingInFailerSFailure extends AuthState {
  final String errorMessage;

  SingInFailerSFailure({required this.errorMessage});
}


// forgot pass


class ResetPasswordLoadingState extends AuthState {}

class ResetPasswordSuccessState extends AuthState {
 // Le constructeur prend un PigeonUserDetails
}

class ResetPasswordFailerSFailure extends AuthState {
  final String errorMessage;

  ResetPasswordFailerSFailure({required this.errorMessage});
}

