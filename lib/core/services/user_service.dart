import 'package:app/core/errors/user_error.dart';
import 'package:app/domain/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  static Future<User> getUserByMatricula(
      {required FirebaseFirestore firestore, required String matricula}) async {
    List<User> users = await _loadUsers(firestore);
    for (User user in users) {
      if (user.userName == matricula) {
        return user;
      }
    }
    throw UserNotFoundException("User with matricula $matricula not found.");
  }

  static Future<User> getUserByUid(
      {required FirebaseFirestore firestore, required String uid}) async {
    var snapshot = await firestore.collection("user").doc(uid).get();
    if (snapshot.data() == null) {
      throw UserNotFoundException("User with uid: $uid not found.");
    }
    return User.fromMap(snapshot.data()!);
  }

  static Future<User?> getUserByEmail(
      {required FirebaseFirestore firestore, required String email}) async {
    List<User> users = await _loadUsers(firestore);
    for (User user in users) {
      if (user.email == email.trim()) return user;
    }
    return null;
  }

  static setUser(
      {required FirebaseFirestore firestore, required User user}) async {
    await firestore.collection("user").doc(user.uid).set(user.toMap());
  }

  static Future<User> updateUser(
      {required FirebaseFirestore firestore, required User user}) async {
    await firestore.collection("user").doc(user.uid).update(user.toMap());
    return user;
  }

  static Future<List<User>> getAllUsers(FirebaseFirestore firestore) async {
    return await _loadUsers(firestore);
  }

  static Future<List<User>> _loadUsers(FirebaseFirestore firestore) async {
    List<User> users = [];
    var snapshot = await firestore.collection("user").get();
    for (var user in snapshot.docs) {
      users.add(User.fromMap(user.data()));
    }
    return users;
  }
}
