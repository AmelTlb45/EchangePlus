abstract class AuthState {}

class AuthInitial extends AuthState {}

class SingupLoadingState extends AuthState {}

class SignupSuccessState extends AuthState {}

class SingupFailerSFailure extends AuthState {
  final String errorMessage;

  SingupFailerSFailure({required this.errorMessage});
}
class TermsAndConditionsUpdateState extends AuthState {}