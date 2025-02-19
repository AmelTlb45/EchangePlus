import 'package:echange_plus/Featrures/auth/presentation/widgets/terms_and_condition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  String? firstName;
  String? lastName;
  String? emailAddress;
  String? password;
  bool? termsAndConditionCheckBoxValue = false;
  GlobalKey<FormState> signupFromKey = GlobalKey();
  void updateFirstName(String firstName) {
    this.firstName = firstName;
    print("Updated firstName: $firstName"); // Vérification
    emit(AuthInitial());
  }

  void updateLastName(String lastName) {
    this.lastName = lastName;
    print("Updated lastName: $lastName"); // Vérification
    emit(AuthInitial());
  }

  void updateEmail(String emailAddress) {
    this.emailAddress = emailAddress;
    print("Updated emailAddress: $emailAddress"); // Vérification
    emit(AuthInitial());
  }

  void updatePassword(String password) {
    this.password = password;
    print("Updated password: $password"); // Vérification
    emit(AuthInitial());
  }

  bool validateFields() {
    if (firstName == null || firstName!.isEmpty) {
      emit(SingupFailerSFailure(errorMessage: "Le prénom est requis"));
      return false;
    }
    if (lastName == null || lastName!.isEmpty) {
      emit(SingupFailerSFailure(errorMessage: "Le nom est requis"));
      return false;
    }
    if (emailAddress == null ||
        emailAddress!.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
            .hasMatch(emailAddress!)) {
      emit(SingupFailerSFailure(errorMessage: "Email invalide"));
      return false;
    }
    if (password == null || password!.isEmpty || password!.length < 8) {
      emit(SingupFailerSFailure(
          errorMessage: "Le mot de passe doit contenir au moins 8 caractères"));
      return false;
    }

    return true; // Si tous les champs sont valides
  }

  // Inscription avec validation préalable
  Future<void> SignUpWithEmailAndPassword() async {
    if (validateFields()) {
      // Si la validation est réussie
      try {
        emit(SingupLoadingState());

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress!,
          password: password!,
        );

        emit(SignupSuccessState());
      } on FirebaseAuthException catch (e) {
        emit(
            SingupFailerSFailure(errorMessage: e.message ?? "Erreur inconnue"));
      } catch (e) {
        emit(SingupFailerSFailure(errorMessage: e.toString()));
      }
    }
  }

  void UpdateTermsAndConditionCheckBox({required bool? newValue}) {
    termsAndConditionCheckBoxValue =
        newValue; // Met à jour la valeur dans le Cubit
    emit(
        TermsAndConditionsUpdateState()); // Émet un nouvel état pour notifier la modification
  }
}
