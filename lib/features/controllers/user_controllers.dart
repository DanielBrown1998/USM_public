import 'package:app/core/errors/user_error.dart';
import 'package:app/domain/models/disciplinas.dart';
import 'package:app/domain/models/matricula.dart';
import "package:app/domain/models/user.dart";
import 'package:app/core/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/core/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth_firebase;

class UserController with ChangeNotifier {
  User? user;
  Matricula? matricula;
  final AuthService authService;
  final FirebaseFirestore firestore;
  UserController({required this.firestore, this.user, AuthService? authService})
      : authService = authService ?? AuthService();

  Future<User?> login({required String email, required String password}) async {
    auth_firebase.User? auth =
        await authService.login(email: email, password: password);
    if (auth == null) {
      throw auth_firebase.FirebaseAuthException(
        code: 'user-not-found',
        message: 'Usuário não encontrado',
      );
    }
    user = await UserService.getUserByUid(firestore: firestore, uid: auth.uid);
    //check if matricula inserted is equal to matricula of authUser
    if (user!.userName != matricula!.matricula) {
      user = null;
      authService.logout();
      throw UserNotFoundException("Matricula nao coincide com o usuario!");
    }
    notifyListeners();
    return user;
  }

  Future<void> logout() async {
    user = null;
    matricula = null;
    notifyListeners();
    await authService.logout();
  }

  Future<bool> forgetPassword(String email) async {
    return await authService.forgetPassword(email);
  }

  Future<User?> register(
      {required String email,
      required String firstName,
      required String lastName,
      required String password,
      required String phone,
      required Matricula matricula,
      isStaff = false,
      isSuperUser = false,
      isActive = true}) async {
    auth_firebase.User? auth = await authService.register(
        name: firstName + lastName, email: email, password: password);

    if (auth == null) return null;
    user = User(
        uid: auth.uid,
        campus: matricula.campus,
        disciplinas: matricula.disciplinas,
        email: email,
        firstName: firstName,
        phone: phone,
        lastName: lastName,
        userName: matricula.matricula,
        dateJoined: auth.metadata.creationTime,
        isActive: isActive,
        isStaff: isStaff,
        isSuperUser: isSuperUser,
        lastLogin: auth.metadata.lastSignInTime);
    notifyListeners();
    await UserService.setUser(firestore: firestore, user: user!);
    return user;
  }

  bool checkDisciplinasThisUserInMatricula() {
    if (user == null || matricula == null) {
      throw UserControllerException('user or matricula not implemented yet');
    }
    if (user!.disciplinas == matricula!.disciplinas) return true;
    user!.disciplinas = matricula!.disciplinas;
    updateUser(user: user!);
    return true;
  }

  Future<bool> removeDisciplinaThisUser(
      {required Disciplina disciplina}) async {
    if (user!.disciplinas.contains(disciplina)) {
      user!.disciplinas.remove(disciplina);
      updateUser(user: user!);
    }
    return false;
  }

  Future<User> updateUser({required User user}) async {
    user = await UserService.updateUser(firestore: firestore, user: user);
    notifyListeners();
    return user;
  }

  Future<User?> getUserByMatriculaForLogin({required String matricula}) async {
    user = await UserService.getUserByMatricula(
        firestore: firestore, matricula: matricula);
    notifyListeners();
    return user;
  }

  Future<User?> getUserByEmailForLogin({required String email}) async {
    return await UserService.getUserByEmail(firestore: firestore, email: email);
  }

  Future<User?> getUserByMatricula({required String matricula}) async {
    if (!(user!.isStaff || user!.isSuperUser)) return null;
    User newUser = await UserService.getUserByMatricula(
        firestore: firestore, matricula: matricula);
    return newUser;
  }

  Future<List<User>> getAllUsers() async {
    return await UserService.getAllUsers(firestore);
  }
}
