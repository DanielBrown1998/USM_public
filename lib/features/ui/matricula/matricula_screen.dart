import 'package:app/features/controllers/disciplinas_controllers.dart';
import 'package:app/features/controllers/user_controllers.dart';
import 'package:app/core/routes/routes.dart';
import 'package:app/core/theme/theme.dart';
import 'package:app/core/utils/utils_user_has_disciplina.dart';
import 'package:app/domain/models/disciplinas.dart';
import 'package:app/features/ui/widgets/gen/appbar.dart';
import 'package:app/features/ui/widgets/cards/matricula_card.dart';
import 'package:app/features/ui/widgets/gen/header.dart';
import 'package:app/features/controllers/matricula_controllers.dart';
import 'package:app/domain/models/matricula.dart';
import 'package:app/features/ui/widgets/stack/stack_usm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MatriculaScreen extends StatefulWidget {
  const MatriculaScreen({super.key});
  @override
  State<MatriculaScreen> createState() => _MatriculaScreenState();
}

class _MatriculaScreenState extends State<MatriculaScreen> {
  bool staffIsMonitor = true;
  List<Matricula> allMatriculas = [];
  List<Matricula> matriculaRegisteredInDisciplineOfMonitor = [];
  bool searched = false;
  final searchMatriculaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Disciplina? disciplinaOfMonitor;

  Future<List<Matricula>> getMatriculasRegisterdInAnyDiscipline(
      Matricula matriculaOfMonitor,
      MatriculaController matriculaController,
      DisciplinasController controllerDisciplina) async {

    List<Matricula> allMatriculas =
        await matriculaController.getAllMatriculas();

    disciplinaOfMonitor = getDisciplinaOfThisMonitor(
        disciplinaController: controllerDisciplina,
        matriculaOfMonitor: matriculaOfMonitor);

    if (disciplinaOfMonitor == null) {
      setState(() {
        staffIsMonitor = false;
      });
      return [];
    } else {
      for (Matricula matricula in allMatriculas) {
        if (matricula.disciplinas.contains(disciplinaOfMonitor)) {
          matriculaRegisteredInDisciplineOfMonitor.add(matricula);
        }
      }
    }

    return allMatriculas;
  }

  Future<List<Matricula>> searchMatricula(String matricula) async {
    List<Matricula> searchedMatriculas = [];
    for (Matricula matriculaModel in allMatriculas) {
      if (matriculaModel.matricula.contains(matricula)) {
        searchedMatriculas.add(matriculaModel);
      }
    }
    return searchedMatriculas;
  }

  @override
  void dispose() {
    searchMatriculaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    MatriculaController matriculaController =
        Provider.of<MatriculaController>(context, listen: false);
    DisciplinasController disciplinasController =
        Provider.of<DisciplinasController>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: USMAppBar.appBar(context, "Matriculas"),
      body: StackUSM(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Header(
                key: Key("matricula_screen_header"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _formKey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                          child: TextFormField(
                        controller: searchMatriculaController,
                        keyboardType: TextInputType.number,
                        enabled: !searched,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "digite algo para pesquisar";
                          } else if (value.length > 12) {
                            return "a matricula deve conter 12 caracteres";
                          }
                          return null;
                        },
                      )),
                      (searched)
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  searched = false;
                                });
                              },
                              icon: Icon(
                                Icons.clear,
                                color: theme.dividerColor,
                              ))
                          : IconButton(
                              onPressed: () {
                                if (_formKey.currentState != null &&
                                    _formKey.currentState!.validate()) {
                                  //for update screen and insert new list
                                  setState(() {
                                    searched = true;
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.search,
                                color: theme.primaryColorDark,
                              )),
                    ],
                  )),
            ),
            Expanded(
              child: Consumer<UserController>(
                builder: (context, userController, child) {
                  return FutureBuilder(
                    future: (searched)
                        ? searchMatricula(searchMatriculaController.text)
                        : getMatriculasRegisterdInAnyDiscipline(
                            userController.matricula!,
                            matriculaController,
                            disciplinasController),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.data!.isEmpty) {
                          return Center(
                            child: Column(
                              spacing: 10,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.no_accounts),
                                Text(
                                  "Sem matriculas na sua disciplina",
                                  style: theme.textTheme.bodyMedium,
                                )
                              ],
                            ),
                          );
                        } else if (!staffIsMonitor) {
                          return Center(
                            child: Column(
                              spacing: 10,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.no_accounts),
                                Text(
                                  "Voce esta como membro da equipe, mas nao esta inscrito como monitor!",
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          );
                        }
                        //clean residualMatricula
                        allMatriculas.clear();
                        matriculaRegisteredInDisciplineOfMonitor.clear();
                        return ListView.builder(
                          key: Key("list_matriculas"),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Matricula data = snapshot.data![index];
                            //insert matricula in local data for search
                            allMatriculas.add(data);
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MatriculaCard(
                                  matricula: data,
                                  matriculaController: matriculaController,
                                  userController: userController,
                                ));
                          },
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.none) {
                        return Center(child: Text("Erro ao carregar dados"));
                      } else if (snapshot.connectionState ==
                          ConnectionState.active) {
                        return Center(child: Text("Erro desconhecido!"));
                      } else {
                        return Center(child: Text("Erro desconhecido!"));
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key("add_matricula"),
        backgroundColor: ThemeUSM.purpleUSMColor,
        splashColor: ThemeUSM.cardColor,
        isExtended: true,
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
            side: BorderSide(color: ThemeUSM.blackColor, width: 2)),
        onPressed: () async {
          if (context.mounted) {
            await Navigator.pushNamed(context, Routes.addMatriculas);
          }
        },
        elevation: 10,
        child: Icon(
          Icons.add,
          color: ThemeUSM.whiteColor,
        ),
      ),
    );
  }
}
