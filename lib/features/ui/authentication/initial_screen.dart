import 'package:app/core/errors/user_error.dart';
import 'package:app/features/ui/widgets/gen/progress_indicator_usm.dart';
import 'package:app/features/ui/widgets/gen/logo_laptop.dart';
import 'package:app/domain/models/matricula.dart';
import 'package:app/features/controllers/matricula_controllers.dart';
import 'package:app/features/controllers/user_controllers.dart';
import 'package:app/core/routes/routes.dart';
import 'package:app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  double _op = 0.0;
  double bottomPadding = 48;
  MainAxisAlignment columnMainAxisAlignment = MainAxisAlignment.center;
  TextEditingController matriculaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    awaitAndSet();
  }

  @override
  void dispose() {
    super.dispose();
  }

  awaitAndSet() async {
    await Future.delayed(Duration(milliseconds: 50));
    setState(() {
      _op = 1;
    });
  }

  Future<void> _searchData(
      BuildContext context, MatriculaController controller) async {
    Matricula? matricula = controller.getMatricula(matriculaController.text);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final snackLoading = messenger.showSnackBar(SnackBar(
        backgroundColor: ThemeUSM.blackColor,
        content: Center(child: ProgressIndicatorUSM())));
    if (matricula != null) {
      //load usercontroller
      UserController users =
          Provider.of<UserController>(context, listen: false);
      try {
        //set matricula and user
        users.matricula = matricula;
        await users.getUserByMatriculaForLogin(matricula: matricula.matricula);

        //udpate disciplinas in user
        users.checkDisciplinasThisUserInMatricula();

        //redirect to login screen

        navigator.pushNamed(Routes.authenticate);
        snackLoading.close();
      } on UserNotFoundException catch (_) {
        snackLoading.close();
        messenger.showSnackBar(
          SnackBar(
            key: Key("matricula_found_user_not"),
            content: Text(
              "Matricula encontrada, Usuario nao, cadastre-se!",
              style: TextStyle(color: ThemeUSM.whiteColor, fontSize: 16),
            ),
            backgroundColor: ThemeUSM.blackColor,
          ),
        );
        //redirect to signin screen

        navigator.popAndPushNamed(Routes.cadastro);
      } on UserControllerException catch (_) {
        snackLoading.close();
        messenger.showSnackBar(
          SnackBar(
            content: Text(
              "houve um erro, tente novamente mais tarde!",
              style: TextStyle(color: ThemeUSM.whiteColor, fontSize: 16),
            ),
            backgroundColor: ThemeUSM.blackColor,
          ),
        );
      }
    } else {
      snackLoading.close();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          key: const Key("key_matricula_not_found"),
          content: Text(
            "Matricula não encontrada, tente novamente.",
            style: TextStyle(color: ThemeUSM.whiteColor, fontSize: 16),
          ),
          backgroundColor: ThemeUSM.blackColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: ThemeUSM.blackColor,
      body: Consumer<MatriculaController>(
          builder: (context, MatriculaController list, child) {
        return Material(
          color: ThemeUSM.blackColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              AnimatedOpacity(
                duration: Duration(milliseconds: 2000),
                curve: Curves.easeInCubic,
                opacity: _op,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "USM",
                      style: TextStyle(
                          color: ThemeUSM.whiteColor,
                          decorationStyle: TextDecorationStyle.solid,
                          fontFamily: "Libertinus",
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                          decoration: TextDecoration.none),
                    ),
                  ),
                ),
              ),
              LogoLaptop(),
              AnimatedOpacity(
                duration: Duration(milliseconds: 2000),
                opacity: _op,
                curve: Curves.easeInCubic,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 40,
                    children: [
                      TextFormField(
                        style: theme.textTheme.displayMedium,
                        controller: matriculaController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelText: "Matricula",
                          icon: Icon(Icons.login),
                          iconColor: ThemeUSM.whiteColor,
                          helperText: "Insira sua matricula",
                          helperStyle: theme.textTheme.displaySmall,
                          constraints: BoxConstraints(
                              minHeight: 60,
                              maxHeight: 120,
                              minWidth: double.maxFinite),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () async {
                                await _searchData(context, list);
                              },
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  "entrar",
                                  style: theme.textTheme.displayLarge,
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
