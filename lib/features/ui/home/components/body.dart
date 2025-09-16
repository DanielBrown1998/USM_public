import 'package:app/features/controllers/disciplinas_controllers.dart';
import 'package:app/features/controllers/user_controllers.dart';
import 'package:app/domain/models/monitoria.dart';
import 'package:app/features/ui/widgets/cards/monitoria_card.dart';
import 'package:app/core/routes/routes.dart';
import 'package:app/core/theme/theme.dart';

import 'package:provider/provider.dart';
import "package:flutter/material.dart";
import 'package:app/features/controllers/monitoria_controllers.dart';

class ListBody extends StatefulWidget {
  final UserController userController;
  const ListBody({super.key, required this.userController});

  @override
  State<ListBody> createState() => _ListBodyState();
}

class _ListBodyState extends State<ListBody> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> buttons = {
      "buscar alunos": Routes.searchStudent,
      "matriculas": Routes.matriculas,
      "monitorias": Routes.monitorias,
      "config": Routes.config,
    };
    List<Map<String, List<dynamic>>> buttonsForStudent = [
      {
        "monitorias": [Routes.monitorias, Icons.add_to_queue_outlined],
      },
      {
        "config": [Routes.config, Icons.settings],
      }
    ];
    final theme = Theme.of(context);
    return (widget.userController.user != null &&
            (widget.userController.user!.isSuperUser ||
                widget.userController.user!.isStaff))
        ? Container(
            color: Colors.transparent,
            height: 64,
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: buttons.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, int i) {
                return Card(
                  borderOnForeground: true,
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: theme.primaryColorDark,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, buttons.values.toList()[i]);
                      },
                      splashColor: theme.primaryColorDark,
                      color: ThemeUSM.blackColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        buttons.keys.toList()[i],
                        style: theme.textTheme.displaySmall,
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        : SizedBox(
            height: 200,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                padding: EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1.15),
                itemCount: buttonsForStudent.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Map<String, List<dynamic>> map = buttonsForStudent[index];

                  return Material(
                    color: Colors.transparent,
                    child: Card(
                      color: ThemeUSM.scaffoldBackgroundColor.withAlpha(200),
                      elevation: 8,
                      shadowColor: theme.colorScheme.onPrimaryFixed,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                            color: theme.colorScheme.onPrimaryContainer,
                            width: 4,
                          )),
                      child: InkWell(
                        customBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(
                              color: theme.colorScheme.onPrimaryContainer,
                              width: 4,
                            )),
                        splashColor: theme.colorScheme.onPrimaryContainer,
                        onTap: () {
                          Navigator.pushNamed(context, map.values.first[0]);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FittedBox(
                              child: Icon(
                                map.values.first[1],
                                size: 36,
                                color: theme.colorScheme.onPrimaryFixed,
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                map.keys.first,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}

class MonitoriaView extends StatefulWidget {
  final UserController userController;
  final DisciplinasController disciplinasController;
  const MonitoriaView(
      {super.key,
      required this.userController,
      required this.disciplinasController});

  @override
  State<MonitoriaView> createState() => _MonitoriaViewState();
}

class _MonitoriaViewState extends State<MonitoriaView> {
  late bool staffFlag;

  @override
  void initState() {
    super.initState();
    staffFlag = widget.userController.user!.isStaff;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Ver como;",
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 10,
                  children: [
                    (widget.userController.user != null &&
                            widget.userController.user!.isStaff)
                        ? ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateColor.resolveWith(
                                (states) => (staffFlag)
                                    ? ThemeUSM.purpleUSMColor
                                    : ThemeUSM.blackColor,
                              ),
                            ),
                            onPressed: () => setState(() {
                              staffFlag = true;
                            }),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "monitor",
                                style: theme.textTheme.displaySmall,
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStateColor.resolveWith(
                        (states) => (!staffFlag)
                            ? ThemeUSM.purpleUSMColor
                            : ThemeUSM.blackColor,
                      )),
                      onPressed: () => setState(() {
                        staffFlag = false;
                      }),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "aluno",
                          style: theme.textTheme.displaySmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.primaryColor.withAlpha(170),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: ThemeUSM.blackColor,
                    width: 3,
                  ),
                ),
                child: Consumer<MonitoriaController>(
                  builder: (BuildContext context, MonitoriaController list,
                      Widget? child) {
                    return FutureBuilder(
                      future: (widget.userController.user!.isStaff && staffFlag)
                          ? list.getStatusMarcadaForStaff(widget.userController,
                              widget.disciplinasController)
                          : list.getStatusMarcadaForStudent(
                              widget.userController),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                          case ConnectionState.done:
                            if (snapshot.data == null ||
                                snapshot.data!.isEmpty) {
                              return Center(
                                  child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child:
                                          Text("Nenhuma monitoria marcada")));
                            }
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final Monitoria monitoria =
                                    snapshot.data![index];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16),
                                  child: MonitoriaCard(
                                    monitoria: monitoria,
                                  ),
                                );
                              },
                            );
                          case ConnectionState.none:
                            return Center(
                                child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text("Erro ao carregar dados")));
                          default:
                            return Center(
                                child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text("Erro desconhecido!")));
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
