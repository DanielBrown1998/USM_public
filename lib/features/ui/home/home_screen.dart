import 'package:app/features/ui/widgets/gen/appbar.dart';
import 'package:app/domain/models/disciplinas.dart';
import 'package:app/features/controllers/disciplinas_controllers.dart';
import 'package:app/features/controllers/user_controllers.dart';
import 'package:app/domain/models/user.dart';
import 'package:app/features/ui/widgets/gen/snackbar_usm.dart';
import 'package:app/features/ui/widgets/stack/stack_usm.dart';
import 'package:flutter/material.dart';
import 'package:app/features/ui/widgets/gen/header.dart';
import 'package:app/features/ui/home/components/drawer.dart';
import 'package:app/core/theme/theme.dart';
import 'package:app/features/ui/widgets/dialogs/all_dialog.dart';
import 'package:app/features/ui/home/components/body.dart' as custom_body;
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //inicializando as disciplinas
    List<Disciplina> allDisciplinas = context.watch<List<Disciplina>>();
    DisciplinasController disciplinasProvider =
        Provider.of<DisciplinasController>(context, listen: false);
    disciplinasProvider.initializeDisciplinas(allDisciplinas);

    addMonitoria() async {
      dynamic value = await alertDialogAddMonitoria(context);
      if (value.runtimeType == List) {
        User user = value[1];
        DateTime date = value[2];
        if (value[0]) {
          if (!context.mounted) return;
          String value =
              "Monitoria marcada: ${date.day}-${date.month}-${date.year}, ${user.firstName}";
          showSnackBarUSM(context, "assets/loties/success.json", value);
        } else {
          if (!context.mounted) return;
          String value =
              "Monitoria NAO marcada: ${date.day}-${date.month}-${date.year}, ${user.firstName}";
          showSnackBarUSM(context, "assets/loties/error.json", value);
        }
      } else if (value is String) {
        if (!context.mounted) return;
        showSnackBarUSM(context, "assets/loties/error.json", value);
      } else {
        if (!context.mounted) return;
        String value = "Monitoria NAO marcada: Erro desconhecido!";
        showSnackBarUSM(context, "assets/loties/error.json", value);
      }
    }

    return Scaffold(
      // backgroundColor: ThemeUSM.shadowColor,
      backgroundColor: Colors.transparent,
      appBar: USMAppBar.appBar(context, widget.title, hasDrawer: true),
      body: StackUSM(
        child: Consumer<UserController>(
          builder: (context, value, _) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Header(
                  key: Key("home_screen_header"),
                ),
              ),
              //only members and super user can access this
              custom_body.ListBody(
                key: Key("home_screen_list"),
                userController: value,
              ),
              //TODO refactor this
              Expanded(
                child: custom_body.MonitoriaView(
                    key: Key("home_screen_monitoria"),
                    userController: value,
                    disciplinasController: disciplinasProvider),
              ),
            ],
          ),
        ),
      ),
      drawer: Consumer<UserController>(
          builder: (BuildContext context, value, Widget? child) {
        if (value.user == null) {
          return Center(
            //TODO refactor this
            child: CircularProgressIndicator(),
          );
        }
        return ListDrawer.list(context, user: value);
      }),
      floatingActionButton: FloatingActionButton(
        key: Key("add_monitoria"),
        backgroundColor: ThemeUSM.blackColor,
        foregroundColor: ThemeUSM.whiteColor,
        onPressed: () async {
          await addMonitoria();
        },
        tooltip: 'Increment',
        elevation: 10,
        heroTag: "add_monitoria",
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
