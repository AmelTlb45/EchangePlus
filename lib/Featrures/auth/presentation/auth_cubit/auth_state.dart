import 'package:echange_plus/Featrures/auth/presentation/widgets/custom_sign_up_form.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class SingupLoadingState extends AuthState {}

class SignupSuccessState extends AuthState {
  final PigeonUserDetails user;  // Au lieu d'une liste, on passe un seul utilisateur

  SignupSuccessState(this.user);  // Le constructeur prend un PigeonUserDetails
}



class SingupFailerSFailure extends AuthState {
  final String errorMessage;

  SingupFailerSFailure({required this.errorMessage});
}
class TermsAndConditionsUpdateState extends AuthState {}