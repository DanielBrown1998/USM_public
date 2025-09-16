import 'package:app/domain/models/disciplinas.dart';
import 'package:app/domain/models/monitoria.dart';
import 'package:app/domain/models/user.dart';
import 'package:app/core/utils/utils_add_monitoria.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //TODO refatorar testes para usar o mockito e testar as excecoes

  test('verificando se uma monitoria pode ser marcada pelo proprio monitor',
      () {
    String matricula = "201243312611";

    Disciplina disciplina = Disciplina(
      id: "FCEE01-14755",
      limitByDay: null,
      nome: "Programacao",
      monitor: matricula,
      campus: "Zona Oeste",
    );

    DateTime date = DateTime(2026, 10, 1, 10, 0);

    User user = User(
        userName: matricula,
        campus: "Zona Oeste",
        email: "teste_teste@hotmail.com",
        disciplinas: [disciplina],
        firstName: "Daniel",
        lastName: "Mingozzi",
        dateJoined: DateTime(2023, 1, 1),
        isSuperUser: false,
        isStaff: false,
        isActive: true,
        lastLogin: DateTime(2023, 1, 1),
        uid: "",
        phone: '21999999999');

    Map<String, dynamic> result =
        isMonitorThisDisciplina(user: user, disciplina: disciplina, date: date);

    expect(result["value"], false);
    expect(result["message"],
        "Usuario e monitor dessa disciplina, nao pode marcar monitoria");

    Monitoria monitoria = formatAddMonitoria(user, disciplina, date);
    expect(monitoria, isA<Monitoria>());
  });
}
