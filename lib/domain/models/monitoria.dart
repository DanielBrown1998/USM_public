import "disciplinas.dart";
import 'package:app/core/helpers/helpers.dart';

class Monitoria {
  final String id;
  final Disciplina disciplina;
  final DateTime date;
  String status;
  final String aluno;
  final String userName;

  Monitoria(
      {required this.id,
      required this.disciplina,
      required this.date,
      required this.aluno,
      required this.userName,
      this.status = Status.marcada});

  Monitoria.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        disciplina = Disciplina.fromMap(map["disciplina"]),
        date = map["date"].toDate(),
        aluno = map["aluno"],
        userName = map["userName"],
        status = map["status"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "disciplina": disciplina.toMap(),
      "aluno": aluno,
      "userName": userName,
      "date": date,
      "status": status
    };
  }
}
