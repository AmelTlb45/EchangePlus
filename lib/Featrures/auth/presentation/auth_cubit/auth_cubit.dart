import 'package:echange_plus/Featrures/auth/presentation/auth_cubit/auth_service.dart';
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
  String? selectedRole = "user"; // Ajouter la variable pour le rôle sélectionné

  GlobalKey<FormState> signupFromKey = GlobalKey();
  GlobalKey<FormState> signinFromKey = GlobalKey();
 GlobalKey<FormState> forgotPasswordFromKey = GlobalKey();
  void updateRole(String? role) {
    selectedRole = role;
    print("Updated role: $selectedRole");
    emit(AuthInitial());
  }

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
        verifyEmail();
        // Crée un objet PigeonUserDetails à partir de userCredential
        PigeonUserDetails user = PigeonUserDetails(
          name: userCredential.user?.displayName ?? 'No Name',
          email: userCredential.user?.email ?? 'No Email',
          role: selectedRole ?? 'user',
        );
       
        // Ajouter le rôle après l'inscription, ici on peut choisir 'user' comme rôle par défaut
        // Ajouter le rôle après l'inscription
        await setUserRole(
            selectedRole!); // Utiliser le rôle sélectionné // Ou 'admin' si tu veux attribuer un rôle admin
       
        emit(SignupSuccessState(user)); // Passe l'objet PigeonUserDetails
      } on FirebaseAuthException catch (e) {
        emit(
            SingupFailerSFailure(errorMessage: e.message ?? "Erreur inconnue"));
      } catch (e) {
        emit(SingupFailerSFailure(errorMessage: e.toString()));
      }
    }
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      emit(SignInLoadingState());
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress!,
        password: password!,
      );
      emit(SignInSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(SingInFailerSFailure(
          errorMessage: 'Vérifier ton email et votre mot de passe !'));
      // Gérer les erreurs spécifiques à Firebase Authentication
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        print('the email is invalid.');
      } else {
        print("Error: ${e.message}");
      }
    } catch (e) {
      // Gérer les autres erreurs
      print("An error occurred: $e");
    }
  }

   verifyEmail() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  // Mettre à jour le rôle de l'utilisateur dans Firestore
  Future<void> setUserRole(String role) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Ajouter un document dans la collection 'users' avec un champ 'role'
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
        {
          'name': "$firstName $lastName", // Nom de l'utilisateur
          'email': user.email ?? 'No Email',
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
   if (user == null) return 'user'; // Utilisateur non connecté
   try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return userDoc.exists ? (userDoc['role'] ?? 'user') : 'user';
   } catch (e) {
      print("Erreur lors de la récupération du rôle : $e");
      return 'user'; // Valeur par défaut en cas d'erreur
   }
}

  // Mettre à jour la case des termes et conditions
  // ignore: non_constant_identifier_names
  void UpdateTermsAndConditionCheckBox({required bool? newValue}) {
    termsAndConditionCheckBoxValue =
        newValue; // Met à jour la valeur dans le Cubit
    emit(
        TermsAndConditionsUpdateState()); // Émet un nouvel état pour notifier la modification
  }

  


   // ignore: non_constant_identifier_names
   Future<void> ResetPasswordWithLink() async {
    try {

   emit(ResetPasswordLoadingState());
     await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress!);
     emit(ResetPasswordSuccessState());
    } catch (e) {
      emit(ResetPasswordFailerSFailure(errorMessage: e.toString()));
     
    }
  }

  

}
