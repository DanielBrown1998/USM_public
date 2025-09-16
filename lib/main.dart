import 'package:app/domain/models/disciplinas.dart';
import 'package:app/domain/models/matricula.dart';
import 'package:app/domain/models/monitoria.dart';
import 'package:app/features/controllers/disciplinas_controllers.dart';
import 'package:app/features/controllers/monitoria_controllers.dart';
import 'package:app/features/controllers/user_controllers.dart';
import 'package:app/features/controllers/matricula_controllers.dart';
import 'package:app/features/ui/matricula/add_matriculas_screen.dart';
import 'package:app/features/ui/authentication/authenticate_screen.dart';
import 'package:app/features/ui/authentication/logout_screen.dart';
import 'package:app/features/ui/authentication/recover_password_screen.dart';

import 'package:app/features/ui/config/config_screen.dart';
import 'package:app/features/ui/matricula/matricula_screen.dart';
import 'package:app/features/ui/monitoria/monitorias_screen.dart';

import 'package:app/features/ui/authentication/initial_screen.dart';
import 'package:app/features/ui/home/home_screen.dart';
import 'package:app/features/ui/authentication/register_screen.dart';
import 'package:app/features/ui/search_student/search_student_screen.dart';
import 'package:app/features/ui/user/user_screen.dart';

import "package:app/core/services/firebase_service.dart" as firebase;
import 'package:app/core/services/matricula_service.dart';
import "package:app/core/services/disciplina_service.dart";
import 'package:app/core/services/monitorias_service.dart';

import 'package:app/core/theme/theme.dart';
import 'package:app/core/routes/routes.dart';
import 'package:app/features/ui/widgets/gen/logo_laptop.dart';
import 'package:app/features/ui/widgets/gen/progress_indicator_usm.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // -> porque a main agora e assincrona
  Provider.debugCheckInvalidValueType = null;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //o segundo run app sobrescrevera este.
  runApp(MaterialApp(home: const _LoadingScreen()));

  //inicialize os crashlytics e os analytics aqui.

  FirebaseFirestore firestore =
      await firebase.FirebaseService.initializeFirebase();

  runApp(MultiProvider(
    providers: [
      FutureProvider<List<Matricula>>.value(
        value: MatriculaService.getAllMatriculas(firestore),
        initialData: [],
        catchError: (context, error) {
          return <Matricula>[];
        },
      ),
      FutureProvider<List<Disciplina>>.value(
        value: DisciplinaService.getDisciplinas(firestore: firestore),
        initialData: [],
        catchError: (context, error) {
          return <Disciplina>[];
        },
      ),
      FutureProvider<List<Monitoria>>.value(
        value: MonitoriasService.getAllMonitorias(firestore),
        initialData: [],
        catchError: (context, error) {
          return <Monitoria>[];
        },
      ),
      //substituindo o ChangeNotifierProvider deixando o listen = false
      ProxyProvider<List<Matricula>, MatriculaController>(
        update: (_, matriculas, previousController) {
          final controller =
              previousController ?? MatriculaController(firestore: firestore);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.initializeMatriculas(matriculas);
          });
          return controller;
        },
      ),
      ProxyProvider<List<Disciplina>, DisciplinasController>(
        update: (_, disciplinas, previousController) {
          final controller =
              previousController ?? DisciplinasController(firestore: firestore);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.initializeDisciplinas(disciplinas);
          });
          return controller;
        },
      ),
      ChangeNotifierProvider<UserController>(
          create: (_) => UserController(firestore: firestore)),
      ChangeNotifierProvider<MonitoriaController>(
          create: (_) => MonitoriaController(firestore: firestore)),
    ],
    child: const USMApp(
      title: "MON. UERJ-ZO",
    ),
  ));
}

class USMApp extends StatelessWidget {
  const USMApp({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final appRoutes = {
      Routes.login: (context) => InitialScreen(),
      Routes.logout: (context) => LogoutScreen(),
      Routes.authenticate: (context) => AuthenticateScreen(),
      Routes.recoverPassword: (context) => RecoverPasswordScreen(),
      Routes.cadastro: (context) => RegisterScreen(),
      Routes.home: (context) => HomeScreen(
            key: const Key('home_screen'),
            title: title,
          ),
      Routes.userScreen: (context) => UserScreen(),
      Routes.searchStudent: (context) => SearchStudentScreen(),
      Routes.monitorias: (context) => MonitoriasSreen(),
      Routes.matriculas: (context) => MatriculaScreen(),
      Routes.addMatriculas: (context) => AddMatriculasScreen(),
      Routes.config: (context) => ConfigScreen(),
    };

    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: USMThemeData.themeData,
      routes: appRoutes,
      initialRoute: Routes.login,
      builder: (context, child) {
        return StreamBuilder<List<ConnectivityResult>>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              return const _LoadingScreen();
            }
            if (snapshot.hasError) {
              return const _ErrorScreen();
            }
            final hasConnection =
                !snapshot.data!.contains(ConnectivityResult.none);
            return Stack(
              children: [
                child!,
                if (!hasConnection) const _NoConnectionScreen(),
              ],
            );
          },
        );
      },
    );
  }
}

/// Widget para a tela de carregamento inicial.
class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ThemeUSM.blackColor,
        alignment: Alignment.center,
        height: double.infinity,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(flex: 3, child: LogoLaptop()),
            Spacer(flex: 1),
            Flexible(flex: 1, child: ProgressIndicatorUSM()),
          ],
        ),
      ),
    );
  }
}

/// Widget para a tela de erro inesperado.
class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: ThemeUSM.blackColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('assets/loties/error.json',
              height: 250, fit: BoxFit.fill),
          Text('Ocorreu um erro inesperado.',
              style: theme.textTheme.displayLarge, textAlign: TextAlign.center),
          Text('Tente reiniciar o aplicativo.',
              style: theme.textTheme.bodyMedium, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

/// Widget para a tela de "sem conexão com a internet".
class _NoConnectionScreen extends StatelessWidget {
  const _NoConnectionScreen();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.red.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/loties/no_internet.json',
                height: 250, fit: BoxFit.fill),
            Text('Verifique sua conexão com a internet.',
                style: theme.textTheme.displayLarge,
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
