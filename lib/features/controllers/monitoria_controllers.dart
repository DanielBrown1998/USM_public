import "package:app/features/controllers/disciplinas_controllers.dart";
import "package:app/features/controllers/user_controllers.dart";
import "package:app/domain/models/disciplinas.dart";
import "package:app/domain/models/monitoria.dart";
import "package:app/core/services/monitorias_service.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:app/core/helpers/helpers.dart";
import 'package:app/core/errors/monitoria_error.dart';

class MonitoriaController with ChangeNotifier {
  final FirebaseFirestore firestore;
  List<Monitoria> monitoria = [];

  MonitoriaController({required this.firestore});

  void initializeMonitorias(List<Monitoria> monitoria) {
    this.monitoria = monitoria;
    notifyListeners();
  }

  Future<List<Monitoria>> loadMonitorias() async {
    return await MonitoriasService.getAllMonitorias(firestore);
  }

  Future<List<Monitoria>> getMarkedMonitoriasbyDate(
      {required DateTime date, required int? limit}) async {
    monitoria = await loadMonitorias();
    notifyListeners();
    List<Monitoria> monitoriasByDate = [];
    if (monitoria != []) {
      monitoriasByDate = monitoria.where((element) {
        return element.date.day == date.day &&
            element.date.month == date.month &&
            element.date.year == date.year;
      }).toList();
    }
    if (limit != null && monitoriasByDate.length >= limit) {
      throw MonitoriaExceedException(
          "Limite de monitorias por dia excedido. Limite: $limit");
    }
    return monitoriasByDate;
  }

  bool _getMonitoriasbyUser(
      {required List<Monitoria> monitorias, required Monitoria monitoria}) {
    bool monitoriasByDate = monitorias
        .where((element) =>
            element.userName == monitoria.userName &&
            element.date.day == monitoria.date.day &&
            element.date.month == monitoria.date.month &&
            element.date.year == monitoria.date.year)
        .isEmpty;
    if (monitoriasByDate == false) {
      throw UserAlreadyMarkDateException(
          "${monitoria.aluno} ja marcou monitoria para esse dia ${monitoria.date.day}/${monitoria.date.month}/${monitoria.date.year}");
    }
    return monitoriasByDate;
  }

  Future<bool> addMonitoria({required Monitoria monitoria}) async {
    bool isMonitoriaThisDay = false;
    List<Monitoria> monitorias = await getMarkedMonitoriasbyDate(
        date: monitoria.date, limit: monitoria.disciplina.limitByDay);
    // print(monitorias);

    if (monitorias == []) {
      isMonitoriaThisDay = true;
    } else {
      isMonitoriaThisDay =
          _getMonitoriasbyUser(monitorias: monitorias, monitoria: monitoria);
    }
    if (isMonitoriaThisDay) {
      await MonitoriasService.saveMonitoria(
          firestore: firestore, monitoria: monitoria);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<List<Monitoria>> getStatusMarcadaForStudent(
      UserController userController) async {
    List<Monitoria> monitoria = await loadMonitorias();
    List<Monitoria> statusMarcada = [];
    statusMarcada = monitoria
        .where((element) =>
            element.status.toString().toUpperCase() == Status.marcada &&
            element.userName == userController.matricula!.matricula)
        .toList();
    return statusMarcada;
  }

  Future<List<Monitoria>> getStatusMarcadaForStaff(
      UserController userController,
      DisciplinasController disciplinasController) async {
    List<Monitoria> monitoria = await loadMonitorias();
    List<Monitoria> statusMarcada = [];
    if (!userController.user!.isStaff) {
      return [];
    }
    Disciplina? disciplinaForThisMember;
    //encontrando a disciplina do membro
    for (Disciplina disciplina in disciplinasController.disciplinas) {
      if (disciplina.monitor == userController.user!.userName) {
        disciplinaForThisMember = disciplina;
      }
    }
    if (disciplinaForThisMember != null) {
      statusMarcada = monitoria
          .where((element) =>
              element.status.toString().toUpperCase() == Status.marcada &&
              element.disciplina == disciplinaForThisMember)
          .toList();
    }
    return statusMarcada;
  }

  Future<Monitoria?> updateStatusMonitoria(
      {required Monitoria monitoria, required String newStatus}) async {
    List<Monitoria> monitorias = await getMarkedMonitoriasbyDate(
        date: monitoria.date, limit: monitoria.disciplina.limitByDay);

    for (Monitoria item in monitorias) {
      if (item.id == monitoria.id) {
        item.status = newStatus;
        await MonitoriasService.saveMonitoria(
            firestore: firestore, monitoria: item);
        notifyListeners();
        return item;
      }
    }
    return null;
  }
}
