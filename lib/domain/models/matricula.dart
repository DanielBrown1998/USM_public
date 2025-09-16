import 'package:app/domain/models/disciplinas.dart';

class Matricula {
  final String matricula;
  final List<Disciplina> disciplinas;
  final String campus;
  Matricula(
      {required this.disciplinas,
      required this.matricula,
      required this.campus});

  Matricula.fromMap(Map<String, dynamic> map)
      : matricula = map["matricula"],
        disciplinas = List.generate(map["disciplinas"].length,
            (index) => Disciplina.fromMap(map["disciplinas"][index])),
        campus = map["campus"];
  Map<String, dynamic> toMap() {
    return {
      "matricula": matricula,
      "disciplinas": disciplinas.map((Disciplina value) => value.toMap()).toList(),
      "campus": campus
    };
  }
}
