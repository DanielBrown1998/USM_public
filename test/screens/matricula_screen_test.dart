// import 'dart:async';

// import 'package:app/controllers/disciplinas_controllers.dart';
// import 'package:app/controllers/matricula_controllers.dart';
// import 'package:app/controllers/user_controllers.dart';
// import 'package:app/domain/models/disciplinas.dart';
// import 'package:app/domain/models/matricula.dart';
// import 'package:app/screen/matricula_screen.dart';
// import 'package:app/screen/widgets/cards/matricula_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';

// import 'matricula_screen_test.mocks.dart';

// @GenerateNiceMocks([
//   MockSpec<MatriculaController>(),
//   MockSpec<UserController>(),
//   MockSpec<DisciplinasController>()
// ])
void main() {
  // group("matricula screen tests", () {
  //   late MockMatriculaController mockMatriculaController;
  //   late MockDisciplinasController mockDisciplinasController;
  //   late MockUserController mockUserController;

  //   // Mock data
  //   late Matricula monitorMatricula;
  //   late Matricula studentMatricula2;
  //   late Disciplina monitorDisciplina;

  //   setUp(() {
  //     mockUserController = MockUserController();
  //     mockDisciplinasController = MockDisciplinasController();
  //     mockMatriculaController = MockMatriculaController();

  //     when(mockUserController.checkDisciplinasThisUserInMatricula())
  //         .thenReturn(true);

  //     // Initialize mock data
  //     monitorDisciplina = Disciplina(
  //         id: 'CS101',
  //         nome: 'Intro to CS',
  //         monitor: '2024001',
  //         campus: 'ZO',
  //         limitByDay: null);

  //     monitorMatricula =
  //         Matricula(matricula: '2024001', campus: 'ZO', disciplinas: []);
  //     studentMatricula2 = Matricula(
  //         matricula: '2024102', campus: 'ZO', disciplinas: [monitorDisciplina]);
  //   });

  //   Future<void> pumpMainWidget(WidgetTester tester) async {
  //     await tester.pumpWidget(
  //       MultiProvider(
  //         providers: [
  //           ChangeNotifierProvider<MatriculaController>.value(
  //             value: mockMatriculaController,
  //           ),
  //           ChangeNotifierProvider<UserController>.value(
  //             value: mockUserController,
  //           ),
  //           ChangeNotifierProvider<DisciplinasController>.value(
  //             value: mockDisciplinasController,
  //           ),
  //         ],
  //         child: MaterialApp(
  //           home: MatriculaScreen(),
  //         ),
  //       ),
  //     );
  //   }

  //   testWidgets("Should show loading indicator while fetching data",
  //       (tester) async {
  //     // Arrange
  //     when(mockUserController.matricula).thenReturn(monitorMatricula);
  //     when(mockDisciplinasController.disciplinas)
  //         .thenReturn([monitorDisciplina]);
  //     // Don't complete the future immediately
  //     when(mockMatriculaController.getAllMatriculas()).thenAnswer((_) async {
  //       // This future will not complete in this test frame
  //       return Completer<List<Matricula>>().future;
  //     });

  //     // Act
  //     await pumpMainWidget(tester);
  //     await tester.pump(); // Pump one frame to show loading

  //     // Assert
  //     expect(find.byType(CircularProgressIndicator), findsOneWidget);
  //   });

  //   testWidgets(
  //       "Should show list of matriculas when monitor has a discipline with students",
  //       (tester) async {
  //     // Arrange
  //     when(mockUserController.matricula).thenReturn(monitorMatricula);
  //     when(mockDisciplinasController.disciplinas)
  //         .thenReturn([monitorDisciplina]);
  //     final future = Future.value([studentMatricula2]);
  //     when(mockMatriculaController.getAllMatriculas())
  //         .thenAnswer((_) => future);

  //     // Act
  //     await pumpMainWidget(tester);
  //     await tester.pump();
  //     await tester.pumpAndSettle();

  //     // Assert
  //     expect(find.byKey(const Key("list_matriculas")), findsOneWidget);
  //     expect(find.byType(MatriculaCard), findsOneWidget);
  //     expect(find.text(studentMatricula2.matricula), findsOneWidget);
  //     expect(find.text("Sem matriculas na sua disciplina"), findsNothing);
  //     expect(
  //         find.text(
  //             "Voce esta como membro da equipe, mas nao esta inscrito como monitor!"),
  //         findsNothing);
  //   });

  //   testWidgets(
  //       "Should show 'Sem matriculas' message when monitor's discipline has no students",
  //       (tester) async {
  //     // Arrange
  //     when(mockUserController.matricula).thenReturn(monitorMatricula);
  //     when(mockDisciplinasController.disciplinas)
  //         .thenReturn([monitorDisciplina]);
  //     // Return a list of matriculas, but none are in the monitor's discipline
  //     final future = Future.value(<Matricula>[]);
  //     when(mockMatriculaController.getAllMatriculas())
  //         .thenAnswer((_) => future);

  //     // Act
  //     await pumpMainWidget(tester);
  //     await tester.pump();
  //     await tester.pumpAndSettle();

  //     // Assert
  //     expect(find.byKey(const Key("list_matriculas")), findsNothing);
  //     expect(find.byType(MatriculaCard), findsNothing);
  //     expect(find.text("Sem matriculas na sua disciplina"), findsOneWidget);
  //     expect(find.byIcon(Icons.no_accounts), findsOneWidget);
  //   });

  //   testWidgets("Should show matricula data", (tester) async {
  //     // Arrange
  //     when(mockUserController.matricula).thenReturn(monitorMatricula);
  //     when(mockDisciplinasController.disciplinas)
  //         .thenReturn([monitorDisciplina]);
  //     final future = Future.value([studentMatricula2]);
  //     when(mockMatriculaController.getAllMatriculas())
  //         .thenAnswer((_) => future);

  //     // Act
  //     await pumpMainWidget(tester);
  //     await tester.pump();
  //     await tester.pumpAndSettle();

  //     Finder card = find.byType(MatriculaCard);
  //     Finder matricula = find.text(studentMatricula2.matricula);
  //     Finder numberDisciplines = find.text(
  //         "numero de disciplinas: ${studentMatricula2.disciplinas.length.toString()}");

  //     expect(card, findsOneWidget);
  //     expect(matricula, findsOneWidget);
  //     expect(numberDisciplines, findsOneWidget);

  //     await tester.tap(card);
  //     await tester.pumpAndSettle();

  //     Finder disciplina = find.text("Disciplinas");

  //     expect(disciplina, findsOneWidget);
  //     expect(numberDisciplines, findsNothing);

  //     for (Disciplina disciplinaStudent in studentMatricula2.disciplinas) {
  //       expect(find.text(disciplinaStudent.nome), findsOneWidget);
  //     }

  //     Finder campus = find.text("Campus");
  //     expect(campus, findsOneWidget);

  //     Finder campusStudent = find.text(studentMatricula2.campus);
  //     expect(campusStudent, findsOneWidget);
  //   });
  // });
}
