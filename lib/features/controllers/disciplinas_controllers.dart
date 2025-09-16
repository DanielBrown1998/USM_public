import 'package:app/domain/models/days.dart';
import 'package:app/core/services/disciplina_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/domain/models/disciplinas.dart';

class DisciplinasController with ChangeNotifier {
  List<Disciplina> disciplinas = [];
  Map<String, List<Days>> days = {};
  final FirebaseFirestore firestore;
  DisciplinasController({required this.firestore});

  void initializeDisciplinas(List<Disciplina> disciplinas) {
    this.disciplinas = disciplinas;
    notifyListeners();
  }

  Future<List<Disciplina>> getDisciplinas() async {
    disciplinas = await DisciplinaService.getDisciplinas(firestore: firestore);
    notifyListeners();
    return disciplinas;
  }

  Future<List<Days>?> getDays({required Disciplina disciplina}) async {
    days[disciplina.id] =
        await DisciplinaService.getDaysOfDisciplineId(firestore, disciplina.id);
    notifyListeners();
    return days[disciplina.id];
  }
}

class DisciplinaNotFoundException implements Exception {
  final String message;
  DisciplinaNotFoundException({required this.message});

  @override
  String toString() {
    return message;
  }
}
