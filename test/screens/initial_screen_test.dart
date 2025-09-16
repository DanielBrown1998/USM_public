import 'package:app/features/controllers/matricula_controllers.dart';
import 'package:app/features/controllers/user_controllers.dart';
import 'package:app/domain/models/disciplinas.dart';
import 'package:app/domain/models/matricula.dart';
import 'package:app/domain/models/user.dart';
import 'package:app/features/ui/authentication/initial_screen.dart';
import 'package:app/features/ui/widgets/gen/logo_laptop.dart';
import 'package:flutter/material.dart';
import 'package:app/core/routes/routes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'initial_screen_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<MatriculaController>(),
  MockSpec<UserController>(),
])
void main() {
  group("testando a inicializacao do tela inicial", () {
    late MockMatriculaController mockMatriculaController;
    late MockUserController mockUserController;
    late Matricula matricula;
    late Disciplina disciplina;
    late User user;
    setUp(() {
      disciplina = Disciplina(
          id: "FCEE01-1745",
          monitor: "202213313000",
          nome: "Daniel",
          campus: "ZO",
          limitByDay: null);
      matricula =
          Matricula(matricula: "202210113245", campus: "ZO", disciplinas: [
        disciplina,
      ]);
      user = User(
        uid: "20tw11233125kjadks13000",
        firstName: "Daniel",
        email: "daniel@usm.br",
        campus: "ZO",
        userName: matricula.matricula,
        lastName: 'Passos',
        phone: '',
        isStaff: false,
        isActive: true,
        isSuperUser: false,
        lastLogin: null,
        dateJoined: null,
        disciplinas: [],
      );
      mockMatriculaController = MockMatriculaController();
      mockUserController = MockUserController();
    });

    Future<void> pumpWidgetMain(WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<MatriculaController>.value(
              value: mockMatriculaController,
            ),
            ChangeNotifierProvider<UserController>.value(
              value: mockUserController,
            ),
          ],
          child: MaterialApp(
            routes: {
              Routes.authenticate: (context) =>
                  const Scaffold(body: Text('Authenticate Screen')),
            },
            home: InitialScreen(),
          ),
        ),
      );
    }

    testWidgets('inicializando a tela inicial', (widgetTester) async {
      //stubs
      when(mockMatriculaController.getMatricula(matricula.matricula))
          .thenReturn(matricula);
      when(mockUserController.getUserByMatriculaForLogin(
              matricula: matricula.matricula))
          .thenAnswer((_) {
        return Future.value(user);
      });

      // Stub for the checkDisciplinasThisUserInMatricula call inside _searchData
      when(mockUserController.checkDisciplinasThisUserInMatricula())
          .thenReturn(true);

      await pumpWidgetMain(widgetTester);
      // pumpAndSettle will wait for animations to finish.
      await widgetTester.pumpAndSettle();
      final usmWidgetFinder = find.text("USM");
      expect(usmWidgetFinder, findsOneWidget);
      expect(find.byType(LogoLaptop), findsOneWidget);
      expect(find.byIcon(Icons.login), findsOneWidget);

      final matriculaFieldFinder =
          find.widgetWithText(TextFormField, "Matricula");
      expect(matriculaFieldFinder, findsOneWidget);

      await widgetTester.enterText(matriculaFieldFinder, matricula.matricula);

      final buttonFinder = find.widgetWithText(TextButton, "entrar");
      expect(buttonFinder, findsOneWidget);
      await widgetTester.tap(buttonFinder);
      await widgetTester.pumpAndSettle();

      // Verify that the correct sequence of methods was called after tapping the button.
      verify(mockMatriculaController.getMatricula(matricula.matricula))
          .called(1);
      verify(mockUserController.getUserByMatriculaForLogin(
              matricula: matricula.matricula))
          .called(1);
      verify(mockUserController.matricula = matricula).called(1);
      verify(mockUserController.checkDisciplinasThisUserInMatricula())
          .called(1);

      // Verify that navigation to the authenticate screen occurred.
      expect(find.text('Authenticate Screen'), findsOneWidget);
    });
  });
}
