import 'package:app/domain/models/disciplinas.dart';
import 'package:app/domain/models/monitoria.dart';
import 'package:app/domain/models/user.dart';

//se user e monitor de uma materia, nao pode pedir monitoria da propria materia que e monitorando
//superusuario nao pode marcar monitorias

Disciplina? updateDisciplinaData(
    Disciplina disciplina, List<Disciplina> allDisciplinas) {
  for (Disciplina item in allDisciplinas) {
    if (disciplina.id == item.id) {
      return item;
    }
  }
  return null;
}

Monitoria formatAddMonitoria(User user, Disciplina disciplina, DateTime date) {
  String id = user.userName +
      date.day.toString() +
      date.month.toString() +
      date.year.toString() +
      date.hour.toString() +
      date.minute.toString();
  Monitoria monitoria = Monitoria(
      id: id,
      disciplina: disciplina,
      date: date,
      aluno: "${user.firstName} ${user.lastName}",
      userName: user.userName);
  return monitoria;
}

Map<String, dynamic> isMonitorThisDisciplina(
    {required User user,
    required Disciplina? disciplina,
    required DateTime date}) {
  Map<String, dynamic> result = {
    "value": true,
    "message": "Usuario pode marcar monitoria para essa disciplina e data"
  };

  if (disciplina == null) {
    result["value"] = false;
    result["message"] = "Selecione uma disciplina!";
  }

  if (disciplina!.monitor == user.userName) {
    result["value"] = false;
    result["message"] =
        "Usuario e monitor dessa disciplina, nao pode marcar monitoria";
  }

  return result;
}
