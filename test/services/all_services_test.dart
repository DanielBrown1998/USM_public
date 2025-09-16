import "package:app/features/controllers/user_controllers.dart";
import "package:app/core/errors/user_error.dart";
import 'package:app/domain/models/user.dart' as model_user;
import "package:app/domain/models/days.dart";
import "package:app/domain/models/disciplinas.dart";
import "package:app/domain/models/matricula.dart";
import "package:app/core/services/auth_service.dart";
import "package:app/core/services/disciplina_service.dart";
import "package:app/core/services/matricula_service.dart";
import 'package:firebase_auth/firebase_auth.dart' as auth;
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";

import "all_services_test.mocks.dart";

@GenerateNiceMocks([
  MockSpec<FirebaseFirestore>(),
  MockSpec<CollectionReference<Map<String, dynamic>>>(),
  MockSpec<QuerySnapshot<Map<String, dynamic>>>(),
  MockSpec<QueryDocumentSnapshot<Map<String, dynamic>>>(),
  MockSpec<DocumentReference<Map<String, dynamic>>>(),
  MockSpec<AuthService>(),
  MockSpec<auth.User>(),
  MockSpec<auth.UserMetadata>(),
  MockSpec<DocumentSnapshot<Map<String, dynamic>>>(),
])
void main() {
  // Initialize the mock objects
  late MockCollectionReference collectionReference;
  late MockQuerySnapshot querySnapshot;
  late MockQueryDocumentSnapshot queryDocumentSnapshot001;
  late MockQueryDocumentSnapshot queryDocumentSnapshot002;
  late MockFirebaseFirestore firestore;
  late MockDocumentReference documentReference;

  setUpAll(() {
    firestore = MockFirebaseFirestore();
  });

  group("DisciplinaController", () {
    late List<Disciplina> expectedDisciplina;
    late String idDisciplina;
    late String collectionDisciplina;
    late String collectionDays;
    late List<Days> expectedDays;
    late MockCollectionReference daysCollection;

    setUp(() {
      collectionReference = MockCollectionReference();
      queryDocumentSnapshot001 = MockQueryDocumentSnapshot();
      documentReference = MockDocumentReference();
      querySnapshot = MockQuerySnapshot();
    });

    test("getDisciplinasIDs returns a list of Disciplinas", () {
      queryDocumentSnapshot002 = MockQueryDocumentSnapshot();
      collectionDisciplina = 'disciplinas';
      expectedDisciplina = [
        Disciplina(
            id: '202213313611',
            limitByDay: null,
            nome: 'Mathematics',
            monitor: 'John Doe',
            campus: 'Main Campus'),
        Disciplina(
            id: '202213313612',
            limitByDay: null,
            nome: 'Physics',
            monitor: 'Jane Smith',
            campus: 'Main Campus'),
      ];

      when(queryDocumentSnapshot001.data()).thenReturn({
        'id': '202213313611',
        'nome': 'Mathematics',
        'monitor': 'John Doe',
        'campus': 'Main Campus'
      });
      when(queryDocumentSnapshot002.data()).thenReturn({
        'id': '202213313612',
        'nome': 'Physics',
        'monitor': 'Jane Smith',
        'campus': 'Main Campus'
      });
      when(querySnapshot.docs)
          .thenReturn([queryDocumentSnapshot001, queryDocumentSnapshot002]);

      when(collectionReference.get()).thenAnswer((_) async {
        return Future.value(querySnapshot);
      });
      when(firestore.collection(collectionDisciplina))
          .thenReturn(collectionReference);

      DisciplinaService.getDisciplinas(firestore: firestore)
          .then((disciplinas) {
        expect(disciplinas, isA<List<Disciplina>>());
        expect(disciplinas.length, equals(expectedDisciplina.length));
        for (int i = 0; i < disciplinas.length; i++) {
          expect(disciplinas[i].id, equals(expectedDisciplina[i].id));
          expect(disciplinas[i].nome, equals(expectedDisciplina[i].nome));
          expect(disciplinas[i].monitor, equals(expectedDisciplina[i].monitor));
          expect(disciplinas[i].campus, equals(expectedDisciplina[i].campus));
        }
      });
    });

    test("getDaysOfDisciplineId", () {
      collectionDays = 'days';
      idDisciplina = '202213313611';

      Map<String, dynamic> hours = {
        "end": "12",
        "start": "7",
        "isActive": true,
      };

      expectedDays = [
        Days(days: 'Monday', hours: hours),
      ];

      daysCollection = MockCollectionReference();
      querySnapshot = MockQuerySnapshot();
      queryDocumentSnapshot001 = MockQueryDocumentSnapshot();

      when(queryDocumentSnapshot001.id).thenReturn('Monday');
      when(queryDocumentSnapshot001.data()).thenReturn({
        'end': '12',
        'start': '7',
        'isActive': true,
      });
      when(querySnapshot.docs).thenReturn([queryDocumentSnapshot001]);
      when(daysCollection.get()).thenAnswer((_) async {
        return Future.value(querySnapshot);
      });

      when(queryDocumentSnapshot001.data()).thenReturn(hours);
      when(queryDocumentSnapshot001.id).thenReturn('Monday');
      when(documentReference.collection(collectionDays))
          .thenReturn(daysCollection);

      when(collectionReference.doc(idDisciplina)).thenReturn(documentReference);
      when(firestore.collection(collectionDisciplina))
          .thenReturn(collectionReference);

      DisciplinaService.getDaysOfDisciplineId(firestore, idDisciplina)
          .then((days) {
        expect(days, isA<List<Days>>());
        expect(days.length, expectedDays.length);
        for (int i = 0; i < days.length; i++) {
          expect(days[i].days, equals(expectedDays[i].days));
          expect(days[i].hours, equals(expectedDays[i].hours));
        }
      });
    });
  });

  group("MatriculaController", () {
    late String collectionMatricula;
    late String matriculaMonitor;
    late String matriculaAluno01;
    late String matriculaAluno02;
    setUp(() {
      collectionReference = MockCollectionReference();
      queryDocumentSnapshot001 = MockQueryDocumentSnapshot();
      documentReference = MockDocumentReference();
      querySnapshot = MockQuerySnapshot();
      collectionMatricula = "matriculas";
      matriculaMonitor = "202213313611";
      matriculaAluno01 = "202213313609";
      matriculaAluno02 = "202213313610";
    });
    test("getDatamatriculaByNumberMatricula", () {
      Disciplina disciplina = Disciplina(
          id: matriculaMonitor,
          limitByDay: null,
          nome: 'Arquitetura de Computadores',
          monitor: 'Daniel Passos',
          campus: 'Zona Oeste');

      Matricula matriculaData = Matricula(
          campus: "Zona Oeste",
          disciplinas: [disciplina],
          matricula: matriculaMonitor);

      when(queryDocumentSnapshot001.data()).thenReturn({
        "matricula": matriculaMonitor.toString(),
        "disciplinas": [disciplina.toMap()],
        "campus": "Zona Oeste"
      });
      when(documentReference.get()).thenAnswer((_) async {
        return Future.value(queryDocumentSnapshot001);
      });
      when(collectionReference.doc(matriculaMonitor))
          .thenReturn(documentReference);
      when(firestore.collection(collectionMatricula))
          .thenReturn(collectionReference);
      MatriculaService.getDataMatriculaByNumberMatricula(
              firestore: firestore, matricula: matriculaMonitor)
          .then((value) {
        expect(value.matricula, matriculaData.matricula);
        expect(value.campus, matriculaData.campus);
        for (int index = 0; index < matriculaData.disciplinas.length; index++) {
          expect(
              value.disciplinas[index].id, matriculaData.disciplinas[index].id);
        }
      });
    });

    test("getAllMatriculas", () {
      queryDocumentSnapshot002 = MockQueryDocumentSnapshot();

      List<Matricula> matriculasExpected = [
        Matricula(
            campus: "Zona Oeste",
            disciplinas: [
              Disciplina(
                  id: 'FCEE01-14755',
                  monitor: matriculaMonitor,
                  nome: "Arquitetura de Computadores",
                  campus: "Zona Oeste",
                  limitByDay: null),
            ],
            matricula: matriculaAluno02),
        Matricula(
            campus: "Zona Oeste",
            disciplinas: [
              Disciplina(
                  id: 'FCEE01-14755',
                  monitor: matriculaMonitor,
                  nome: "Arquitetura de Computadores",
                  campus: "Zona Oeste",
                  limitByDay: null),
            ],
            matricula: matriculaAluno01)
      ];
      when(queryDocumentSnapshot002.data())
          .thenReturn(matriculasExpected[1].toMap());

      when(queryDocumentSnapshot001.data())
          .thenReturn(matriculasExpected[0].toMap());
      when(querySnapshot.docs)
          .thenReturn([queryDocumentSnapshot001, queryDocumentSnapshot002]);
      when(collectionReference.get())
          .thenAnswer((_) async => Future.value(querySnapshot));
      when(firestore.collection(collectionMatricula))
          .thenReturn(collectionReference);

      MatriculaService.getAllMatriculas(firestore).then(
        (List<Matricula> matriculas) {
          expect(matriculas, isA<List<Matricula>>());
          expect(matriculas.length, matriculasExpected.length);
          int i = 0;
          for (Matricula item in matriculas) {
            expect(item.campus, matriculasExpected[i].campus);
            expect(item.matricula, matriculasExpected[i].matricula);
            expect(item.disciplinas.length,
                matriculasExpected[i].disciplinas.length);
            i++;
          }
        },
      );
    });
  });

  group("UserController", () {
    late MockFirebaseFirestore firestore;
    late MockAuthService mockAuthService;
    late UserController userController;
    late MockCollectionReference usersCollection;
    late MockDocumentReference userDocumentReference;
    late MockDocumentSnapshot userDocumentSnapshot;

    // Mock data
    const String testEmail = 'test@test.com';
    const String testPassword = 'password';
    const String matricula = "000000000000";
    const String testUid = 'testUid';
    final now = DateTime.now();
    final timestampNow = Timestamp.fromDate(now);

    final testUser = model_user.User(
      uid: testUid,
      firstName: 'Test',
      lastName: 'User',
      email: testEmail,
      userName: matricula,
      campus: 'Test Campus',
      dateJoined: now,
      disciplinas: [],
      isActive: true,
      isStaff: false,
      isSuperUser: false,
      lastLogin: now,
      phone: '1234567890',
    );

    final testUserMap = {
      'uid': testUser.uid,
      'firstName': testUser.firstName,
      'lastName': testUser.lastName,
      'email': testUser.email,
      'userName': testUser.userName,
      'campus': testUser.campus,
      'dateJoined': timestampNow,
      'disciplinas': [],
      'isActive': testUser.isActive,
      'isStaff': testUser.isStaff,
      'isSuperUser': testUser.isSuperUser,
      'lastLogin': timestampNow,
      'phone': testUser.phone,
    };

    setUp(() {
      firestore = MockFirebaseFirestore();
      mockAuthService = MockAuthService();
      userController =
          UserController(firestore: firestore, authService: mockAuthService);

      // Firestore mocks for UserService
      usersCollection = MockCollectionReference();
      userDocumentReference = MockDocumentReference();
      userDocumentSnapshot = MockDocumentSnapshot();

      when(userDocumentReference.get())
          .thenAnswer((_) async => userDocumentSnapshot);
      when(usersCollection.doc(any)).thenReturn(userDocumentReference);
      when(firestore.collection('user')).thenReturn(usersCollection);
    });

    group('login', () {
      test('should return User and set user on successful login', () async {
        // Arrange
        final mockAuthUser = MockUser();
        final matriculaModel = Matricula(
          campus: "Zona Oeste",
          disciplinas: [],
          matricula: matricula,
        );
        userController.matricula = matriculaModel;

        when(mockAuthUser.uid).thenReturn(testUid);
        when(mockAuthService.login(email: testEmail, password: testPassword))
            .thenAnswer((_) async => mockAuthUser);

        when(userDocumentSnapshot.exists).thenReturn(true);
        when(userDocumentSnapshot.data()).thenReturn(testUserMap);
        when(usersCollection.doc(testUid)).thenReturn(userDocumentReference);

        // Act
        final result = await userController.login(
            email: testEmail, password: testPassword);

        // Assert
        expect(result, isA<model_user.User>());
        expect(userController.user, isA<model_user.User>());
        expect(userController.user!.uid, testUid);
        verify(mockAuthService.login(email: testEmail, password: testPassword))
            .called(1);
        verify(firestore.collection('user')).called(1);
        verify(usersCollection.doc(testUid)).called(1);
      });

      test('should throw FirebaseAuthException when authService login fails',
          () async {
        // Arrange
        when(mockAuthService.login(email: testEmail, password: testPassword))
            .thenThrow(
          auth.FirebaseAuthException(
            code: 'user-not-found',
            message: 'User not found',
          ),
        );

        // Act & Assert
        expect(
            () async => await userController.login(
                email: testEmail, password: testPassword),
            throwsA(isA<auth.FirebaseAuthException>()));
        expect(userController.user, isNull);
        verifyNever(firestore.collection('user'));
      });

      test(
          "should return false when user.userName != matricula inserted before ",
          () async {
        final mockAuthUser = MockUser();
        final matriculaModel = Matricula(
          campus: "Zona Oeste",
          disciplinas: [],
          matricula: "000000000001",
        );
        userController.matricula = matriculaModel;

        when(mockAuthUser.uid).thenReturn(testUid);
        when(mockAuthService.login(email: testEmail, password: testPassword))
            .thenAnswer((_) async => mockAuthUser);

        when(userDocumentSnapshot.exists).thenReturn(true);
        when(userDocumentSnapshot.data()).thenReturn(testUserMap);
        when(usersCollection.doc(testUid)).thenReturn(userDocumentReference);

        // Assert
        expect(
            () async => await userController.login(
                email: testEmail, password: testPassword),
            throwsA(isA<UserNotFoundException>()));
        expect(userController.user, isNull);
        verify(mockAuthService.login(email: testEmail, password: testPassword))
            .called(1);
        // verify(firestore.collection('user')).called(1);
        // verify(usersCollection.doc(testUid)).called(1);
      });

      test('should throw UserNotFoundException if user not in firestore',
          () async {
        // Arrange
        final mockAuthUser = MockUser();
        final matriculaModel = Matricula(
          campus: "Zona Oeste",
          disciplinas: [],
          matricula: matricula,
        );
        userController.matricula = matriculaModel;

        when(mockAuthUser.uid).thenReturn(testUid);
        when(mockAuthService.login(email: testEmail, password: testPassword))
            .thenAnswer((_) async => mockAuthUser);

        when(userDocumentSnapshot.exists).thenReturn(false);
        when(usersCollection.doc(testUid)).thenReturn(userDocumentReference);

        // Act & Assert
        expect(
            () async => await userController.login(
                email: testEmail, password: testPassword),
            throwsA(isA<UserNotFoundException>()));
        expect(userController.user, isNull);
      });
    });

    group('logout', () {
      test('should clear user and call authService.logout', () async {
        // Arrange
        userController.user = testUser; // Pre-set a user
        when(mockAuthService.logout()).thenAnswer((_) async {});

        // Act
        await userController.logout();

        // Assert
        expect(userController.user, isNull);
        expect(userController.matricula, isNull);
        verify(mockAuthService.logout()).called(1);
      });
    });

    group('register', () {
      late Matricula testMatricula;
      late MockUser mockAuthUser;
      late MockUserMetadata mockUserMetadata;

      setUp(() {
        testMatricula = Matricula(
            matricula: '202312345', campus: 'Test Campus', disciplinas: []);
        mockAuthUser = MockUser();
        mockUserMetadata = MockUserMetadata();

        when(mockAuthUser.uid).thenReturn(testUid);
        when(mockAuthUser.metadata).thenReturn(mockUserMetadata);
        when(mockUserMetadata.creationTime).thenReturn(now);
        when(mockUserMetadata.lastSignInTime).thenReturn(now);
      });

      test('should return user and set user on successful registration',
          () async {
        // Arrange
        when(mockAuthService.register(
          email: testEmail,
          password: testPassword,
          name: 'TestUser',
        )).thenAnswer((_) async => mockAuthUser);

        when(userDocumentReference.set(any)).thenAnswer((_) async {});

        // Act
        final result = await userController.register(
          email: testEmail,
          firstName: 'Test',
          lastName: 'User',
          password: testPassword,
          phone: '1234567890',
          matricula: testMatricula,
        );

        // Assert
        expect(result, isA<model_user.User>());

        expect(result!.uid, testUid);
        expect(userController.user, isNotNull);
        expect(userController.user!.uid, testUid);

        verify(mockAuthService.register(
          email: testEmail,
          password: testPassword,
          name: 'TestUser',
        )).called(1);
        verify(userDocumentReference.set(any)).called(1);
      });

      test('should return null when authService registration fails', () async {
        // Arrange
        when(mockAuthService.register(
          email: testEmail,
          password: testPassword,
          name: 'TestUser',
        )).thenAnswer((_) async => null);

        // Act
        final result = await userController.register(
          email: testEmail,
          firstName: 'Test',
          lastName: 'User',
          password: testPassword,
          phone: '1234567890',
          matricula: testMatricula,
        );

        // Assert
        expect(result, isNull);
        expect(userController.user, isNull);
        verifyNever(userDocumentReference.set(any));
      });
    });
  });
}
