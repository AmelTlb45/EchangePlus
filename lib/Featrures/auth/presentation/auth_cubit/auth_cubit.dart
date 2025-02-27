import 'package:echange_plus/Featrures/auth/presentation/widgets/custom_sign_up_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  String? firstName;
  String? lastName;
  String? emailAddress;
  String? password;
  bool? termsAndConditionCheckBoxValue = false;
  GlobalKey<FormState> signupFromKey = GlobalKey();

  // Mettre à jour le prénom
  void updateFirstName(String firstName) {
    this.firstName = firstName;
    print("Updated firstName: $firstName");
    emit(AuthInitial());
  }

  // Mettre à jour le nom de famille
  void updateLastName(String lastName) {
    this.lastName = lastName;
    print("Updated lastName: $lastName");
    emit(AuthInitial());
  }

  // Mettre à jour l'email
  void updateEmail(String emailAddress) {
    this.emailAddress = emailAddress;
    print("Updated emailAddress: $emailAddress");
    emit(AuthInitial());
  }

  // Mettre à jour le mot de passe
  void updatePassword(String password) {
    this.password = password;
    print("Updated password: $password");
    emit(AuthInitial());
  }

  // Validation des champs du formulaire
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
      try {
        emit(SingupLoadingState()); // Afficher un indicateur de chargement

        // Créer l'utilisateur avec Firebase
        var userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress!,
          password: password!,
        );

        // Crée un objet PigeonUserDetails à partir de userCredential
        PigeonUserDetails user = PigeonUserDetails(
          name: userCredential.user?.displayName ?? 'No Name',
          email: userCredential.user?.email ?? 'No Email',
        );

        // Ajouter le rôle après l'inscription, ici on peut choisir 'user' comme rôle par défaut
        await setUserRole(
            'user'); // Ou 'admin' si tu veux attribuer un rôle admin

        // Émettre un état de succès avec l'objet PigeonUserDetails
        emit(SignupSuccessState(user)); // Passe l'objet PigeonUserDetails
      } on FirebaseAuthException catch (e) {
        emit(
            SingupFailerSFailure(errorMessage: e.message ?? "Erreur inconnue"));
      } catch (e) {
        emit(SingupFailerSFailure(errorMessage: e.toString()));
      }
    }
  }

  // Mettre à jour le rôle de l'utilisateur dans Firestore
  Future<void> setUserRole(String role) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Ajouter un document dans la collection 'users' avec un champ 'role'
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
        {
          'role': role, // Enregistrer le rôle
        },
        SetOptions(
            merge:
                true), // Utiliser merge pour ne pas écraser les autres champs
      );
    }
  }

  Future<String> getUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Récupérer le rôle de l'utilisateur depuis Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        return userDoc['role'] ??
            'user'; // Retourner 'user' si aucun rôle n'est défini
      }
    }
    return 'user'; // Valeur par défaut si l'utilisateur n'est pas authentifié ou si aucun rôle n'est défini
  }

  // Mettre à jour la case des termes et conditions
  void UpdateTermsAndConditionCheckBox({required bool? newValue}) {
    termsAndConditionCheckBoxValue =
        newValue; // Met à jour la valeur dans le Cubit
    emit(
        TermsAndConditionsUpdateState()); // Émet un nouvel état pour notifier la modification
  }
}
