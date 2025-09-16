import 'package:app/features/controllers/disciplinas_controllers.dart';
import 'package:app/domain/models/disciplinas.dart';
import 'package:app/domain/models/matricula.dart';

Disciplina? getDisciplinaOfThisMonitor(
    {required DisciplinasController disciplinaController,
    required Matricula matriculaOfMonitor}) {
  Disciplina? disciplinaOfMonitor;
  for (Disciplina disciplina in disciplinaController.disciplinas) {
    if (disciplina.monitor == matriculaOfMonitor.matricula) {
      disciplinaOfMonitor = disciplina;
    }
  }
  return disciplinaOfMonitor;
}
