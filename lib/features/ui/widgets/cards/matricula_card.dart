import 'package:app/features/controllers/matricula_controllers.dart';
import 'package:app/features/controllers/user_controllers.dart';
import 'package:app/core/theme/theme.dart';
import 'package:app/domain/models/matricula.dart';
import 'package:app/domain/models/user.dart' as model_user;
import 'package:app/features/ui/matricula/add_matriculas_screen.dart';
import 'package:flutter/material.dart';

class MatriculaCard extends StatefulWidget {
  final Matricula matricula;
  final MatriculaController matriculaController;
  final UserController userController;
  const MatriculaCard(
      {super.key,
      required this.matricula,
      required this.matriculaController,
      required this.userController});

  @override
  State<MatriculaCard> createState() => _MatriculaCardState();
}

class _MatriculaCardState extends State<MatriculaCard> {
  bool flagShowDataOfMatricula = false;
  late bool hasUserWithThisMatricula;

  Future<model_user.User?> searchUserWithThisMatricula(
      Matricula matricula) async {
    final List<model_user.User> users =
        await widget.userController.getAllUsers();

    for (model_user.User user in users) {
      if (user.userName == matricula.matricula) {
        return user;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final size = MediaQuery.sizeOf(context);
    return Dismissible(
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {}
      },
      onUpdate: (details) {
        if (details.progress >= .3) {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return AddMatriculasScreen(
                matricula: widget.matricula,
              );
            },
          ));
        }
      },
      background: Container(
        decoration: BoxDecoration(color: ThemeUSM.purpleUSMColor),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 5,
            children: [
              Text(
                "atualizar",
                style: theme.textTheme.displaySmall,
              ),
              Icon(
                Icons.update,
                color: theme.primaryColor,
              ),
            ],
          ),
        )),
      ),
      direction: DismissDirection.endToStart,
      key: Key(widget.matricula.matricula),
      child: AnimatedSize(
        duration: Duration(milliseconds: 750),
        curve: Curves.linear,
        onEnd: () {},
        alignment: AlignmentGeometry.topCenter,
        reverseDuration: Duration(milliseconds: 1000),
        child: Card(
          shadowColor: ThemeUSM.purpleUSMColor,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: ThemeUSM.purpleUSMColor, width: 2)),
          child: InkWell(
            onTap: () {
              setState(() {
                flagShowDataOfMatricula = !flagShowDataOfMatricula;
              });
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 50,
                      child: Icon(
                        Icons.arrow_back_ios,
                      )),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      spacing: 5,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          widget.matricula.matricula,
                          style: theme.textTheme.bodyLarge,
                        ),
                        Visibility(
                          visible: !flagShowDataOfMatricula,
                          child: Text(
                            "numero de disciplinas: ${widget.matricula.disciplinas.length.toString()}",
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        Visibility(
                            visible: flagShowDataOfMatricula,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                FutureBuilder(
                                  future: searchUserWithThisMatricula(
                                      widget.matricula),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text("Erro ao procurar usuario");
                                    } else if (snapshot.hasData &&
                                        snapshot.connectionState ==
                                            ConnectionState.done) {
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                              "nome: ${snapshot.data!.firstName} ${snapshot.data!.lastName}"),
                                          Icon(
                                            Icons.circle,
                                            color: (snapshot.data!.isActive)
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Text(
                                          "Sem usuario com essa matricula");
                                    }
                                  },
                                ),
                                Text(
                                  "Disciplinas",
                                  style: theme.textTheme.bodyLarge,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: List<Widget>.generate(
                                    widget.matricula.disciplinas.length,
                                    (index) => Text(
                                      widget.matricula.disciplinas[index].nome,
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Campus",
                                  style: theme.textTheme.bodyLarge,
                                ),
                                Text(
                                  widget.matricula.campus,
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
