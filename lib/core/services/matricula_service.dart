import 'package:app/core/errors/user_error.dart';
import 'package:app/domain/models/matricula.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MatriculaService {
  static Future<Matricula> getDataMatriculaByNumberMatricula(
      {required FirebaseFirestore firestore, required String matricula}) async {
    var snapshot =
        await firestore.collection("matriculas").doc(matricula).get();
    if (snapshot.data() == null) {
      throw UserNotFoundException("User with matricula $matricula not found.");
    }
    return Matricula.fromMap(snapshot.data()!);
  }

  static Future<List<Matricula>> getAllMatriculas(
      FirebaseFirestore firestore) async {
    List<Matricula> matriculas = [];
    var snapshot = await firestore.collection("matriculas").get();
    for (var item in snapshot.docs) {
      Matricula matricula = Matricula.fromMap(item.data());
      matriculas.add(matricula);
    }
    return matriculas;
  }

  static Future<bool> setMatricula(
      FirebaseFirestore firestore, Matricula matricula) async {
    try {
      await firestore
          .collection("matriculas")
          .doc(matricula.matricula)
          .set(matricula.toMap());
      return true;
    } on FirebaseException catch (_) {
      return false;
    }
  }

  static Future<bool> updateMatricula(
      FirebaseFirestore firestore, Matricula matricula) async {
    try {
      await firestore
          .collection("matriculas")
          .doc(matricula.matricula)
          .update(matricula.toMap());
      return true;
    } on FirebaseException catch (_) {
      return false;
    }
  }
}
