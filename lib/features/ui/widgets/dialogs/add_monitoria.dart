part of 'all_dialog.dart';

Future<dynamic> alertDialogAddMonitoria(BuildContext context) {
  UserController users = Provider.of<UserController>(context, listen: false);
  User? user = users.user;

  final formkey = GlobalKey<FormState>();

  Disciplina? disciplinaByUser;
  DisciplinasController allDisciplinas =
      Provider.of<DisciplinasController>(context, listen: false);
  DateTime date = DateTime.now().add(Duration(days: 1));
  final size = MediaQuery.sizeOf(context);
  final theme = Theme.of(context);
  AlertDialog alert = AlertDialog(
    backgroundColor: theme.primaryColor,
    elevation: 20,
    shadowColor: theme.colorScheme.onPrimaryFixed,
    insetPadding: EdgeInsets.zero,
    title: Text(
      "Marcar Monitoria",
    ),
    titleTextStyle: theme.primaryTextTheme.bodyLarge,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(
        color: theme.colorScheme.onPrimaryFixed,
        width: 4,
      ),
    ),
    content: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      constraints: BoxConstraints(
          maxHeight: 500,
          minHeight: 350,
          maxWidth: double.maxFinite,
          minWidth: 200),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          spacing: 20,
          children: [
            SizedBox(
              width: size.width * 0.3,
              height: size.width * 0.3,
              child: Image.asset(
                key: Key("add_monitoria_image"),
                "assets/images/logomarca-uerj.png",
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Form(
                key: formkey,
                child: Column(
                  spacing: 10,
                  children: [
                    TextFormField(
                      enabled: false,
                      initialValue: user!.userName,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Matricula",
                          labelStyle: theme.primaryTextTheme.bodyMedium,
                          helperText: "insira a matricula do aluno"),
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                    DropdownButtonFormField(
                        items: List.generate(
                            user.disciplinas.length,
                            (index) => DropdownMenuItem(
                                  value: user.disciplinas[index],
                                  child: Text(user.disciplinas[index].nome),
                                )),
                        decoration: InputDecoration(
                          labelText: "Disciplina",
                          labelStyle: theme.primaryTextTheme.bodyMedium,
                        ),
                        onChanged: (value) {
                          if (value != null) disciplinaByUser = value;
                        }),
                    DateTimeFormField(
                      onChanged: (newValue) {
                        if (newValue != null) {
                          date = newValue;
                        }
                      },
                      firstDate: DateTime.now().add(Duration(days: 1)),
                      lastDate: DateTime.now().add(Duration(days: 8)),
                      decoration: InputDecoration(
                          labelText: "Insira o Dia",
                          labelStyle: theme.primaryTextTheme.bodyMedium,
                          helperText: "insira um dia da semana disponivel"),
                      validator: (value) {
                        return null;
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    actions: [
      IconButton(
          onPressed: () async {
            try {
              //usuario esta apto a pedir essa monnitoria?
              Map<String, dynamic> isUserValid = isMonitorThisDisciplina(
                  user: user, disciplina: disciplinaByUser, date: date);
              if (!isUserValid["value"]) {
                if (disciplinaByUser != null) {
                  users.removeDisciplinaThisUser(disciplina: disciplinaByUser!);
                }
                throw UserisNotAvailableToMonitoriaException(
                    isUserValid['message'].toString());
              }
              //atualizando a disciplina contida no usuario
              Disciplina? disciplinaUpdated = updateDisciplinaData(
                  disciplinaByUser!, allDisciplinas.disciplinas);

              if (disciplinaUpdated != null) {
                disciplinaByUser = disciplinaUpdated;
              }
              //formatando a monitoria
              Monitoria formatedDataToMonitoria =
                  formatAddMonitoria(user, disciplinaByUser!, date);

              //carregando as monitorias
              MonitoriaController monitorias =
                  Provider.of<MonitoriaController>(context, listen: false);

              bool isUserAdded = await monitorias.addMonitoria(
                  monitoria: formatedDataToMonitoria);

              List<dynamic> resultAddDataMonitoria = [isUserAdded, user, date];
              if (!context.mounted) return;
              Navigator.pop(context, resultAddDataMonitoria);
            } on MonitoriaExceedException catch (e) {
              Navigator.pop(context, e.message);
            } on UserAlreadyMarkDateException catch (e) {
              Navigator.pop(context, e.message);
            } on UserisNotAvailableToMonitoriaException catch (e) {
              Navigator.pop(context, e.message);
            } on Exception catch (_) {
              Navigator.pop(context, "Erro desconhecido");
            }
          },
          icon: Icon(Icons.add_task)),
      IconButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          icon: Icon(Icons.highlight_remove_sharp))
    ],
  );

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
