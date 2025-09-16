import "package:app/domain/models/matricula.dart";
import "package:app/core/services/matricula_service.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class MatriculaController with ChangeNotifier {
  final FirebaseFirestore firestore;

  MatriculaController({required this.firestore});

  List<Matricula> matriculas = [];

  void initializeMatriculas(List<Matricula> matriculas) {
    this.matriculas = matriculas;
    notifyListeners();
  }

  Matricula? getMatricula(String matricula) {
    for (Matricula item in matriculas) {
      if (item.matricula == matricula) {
        return item;
      }
    }
    return null;
  }

  Future<bool> setMatricula(Matricula matricula) async {
    return await MatriculaService.setMatricula(firestore, matricula);
  }

  Future<bool> updateMatricula(Matricula matricula) async {
    return await MatriculaService.updateMatricula(firestore, matricula);
  }

  Future<List<Matricula>> getAllMatriculas() async {
    return await MatriculaService.getAllMatriculas(firestore);
  }
}
