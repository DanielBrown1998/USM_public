import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get getUser => _firebaseAuth.currentUser;

  Future<User?> login({required String email, required String password}) async {
    UserCredential credentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return credentials.user;
  }

  Future<void> logout() async {
    _firebaseAuth.signOut();
  }

  Future<User?> register(
      {required String email,
      required String password,
      required String name}) async {
    UserCredential newUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    User user = newUser.user!;

    // TODO implements phone check and email check
    user.updateDisplayName(name);
    return user;
  }

  Future<bool> forgetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint("Error: ${e.code}");
      debugPrint("Error sending password reset email: ${e.message}");
      return false;
    }
  }

  Future<bool> sendEmailVerification(String email) async {
    User? user = _firebaseAuth.currentUser;
    if (user != null && user.emailVerified == false) {
      await user.sendEmailVerification();
      return true;
    }
    return false;
  }

  //check phone after register for validation future
  Future<void> verifyPhoneAndUpdate(String phoneNumber) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        User? user = _firebaseAuth.currentUser;
        if (user != null) {
          await user.updatePhoneNumber(credential);
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        throw PhoneVerificationFailedException(
            message: "A verificacao de telefone falhou!");
      },
      codeSent: (String verificationId, int? resendToken) {
        // Peça para o usuário inserir o código SMS recebido
        // Depois, crie o credential e chame user.updatePhoneNumber(credential)
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}

class PhoneVerificationFailedException {
  final String message;
  PhoneVerificationFailedException({required this.message});
  @override
  String toString() {
    return message;
  }
}
