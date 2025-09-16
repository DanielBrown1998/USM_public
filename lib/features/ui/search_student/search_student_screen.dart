import 'package:app/features/ui/widgets/stack/stack_usm.dart';
import 'package:flutter/material.dart';
import 'package:app/core/errors/user_error.dart';
import 'package:app/core/theme/theme.dart';
import 'package:app/domain/models/user.dart';
import 'package:app/features/ui/widgets/gen/appbar.dart';
import 'package:app/features/ui/widgets/gen/header.dart';
import 'package:app/features/ui/widgets/dialogs/all_dialog.dart';
import 'package:app/features/ui/widgets/cards/student_card.dart';
import 'package:app/features/controllers/user_controllers.dart';
import 'package:provider/provider.dart';

class SearchStudentScreen extends StatefulWidget {
  const SearchStudentScreen({super.key});

  @override
  State<SearchStudentScreen> createState() => _SearchStudentScreenState();
}

class _SearchStudentScreenState extends State<SearchStudentScreen> {
  final _formkey = GlobalKey<FormState>();
  bool isSearched = false;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _matricula = TextEditingController();
  List<User> allUsers = [];

  Future<List<User>?> searchStudent(
      BuildContext context, UserController controller) async {
    final String name = _name.text;
    final String email = _email.text;
    final String matricula = _matricula.text;
    if (name == "" && email == "" && matricula == "") {
      return await alertDialogStudent(context,
          title: "Atencao",
          msg: "preencha algum campo!!!",
          confirmation: "sim",
          icon: Icons.dangerous_outlined);
    }

    isSearched = true;
    allUsers.clear();

    if (matricula != "" && matricula.length == 12) {
      try {
        User? user = await controller.getUserByMatricula(matricula: matricula);
        if (user != null) {
          allUsers.add(user);
          setState(() {});
          return allUsers;
        }
      } on UserNotFoundException catch (_) {
        setState(() {});
        return allUsers;
      }
    }
    //TODO inserir a logica se todos sao nao nulos
    allUsers = await controller.getAllUsers();
    allUsers = allUsers.where((User test) {
      final bool userFirstNameContainsName =
          "${test.lastName.toLowerCase()}-${test.firstName.toLowerCase()}"
              .contains(name.toLowerCase().trim());
      if (name.isNotEmpty && email.isNotEmpty && matricula.isEmpty) {
        if (userFirstNameContainsName && (test.email == email)) {
          return true;
        }
        return false;
      } else if (name.isNotEmpty && email.isEmpty && matricula.isNotEmpty) {
        if (userFirstNameContainsName && (test.userName.contains(matricula))) {
          return true;
        }
        return false;
      } else if (name.isEmpty && email.isNotEmpty && matricula.isNotEmpty) {
        if ((test.email == email) && (test.userName.contains(matricula))) {
          return true;
        }
        return false;
      } else {
        if ((userFirstNameContainsName && name.isNotEmpty) ||
            ((test.email == email) && email.isNotEmpty) ||
            (test.userName.contains(matricula) && matricula.isNotEmpty)) {
          return true;
        }
        return false;
      }
    }).toList();

    setState(() {});
    return allUsers;
  }

  switchWidget(User user, bool showCardUser) {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final media = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: USMAppBar.appBar(context, "Buscar Aluno"),
      body: StackUSM(
        child: Consumer<UserController>(
          builder: (context, controller, _) {
            return SingleChildScrollView(
              child: Column(
                spacing: 5.5,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: (!isSearched)
                        ? Header(
                            key: null,
                          )
                        : SizedBox.shrink(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black87, width: 4),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: theme.primaryColor,
                      ),
                      child: SizedBox(
                        width: 400,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "Insira algum desses Dados",
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ),
                              Form(
                                key: _formkey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _name,
                                      keyboardType: TextInputType.text,
                                      decoration:
                                          InputDecoration(labelText: "Nome"),
                                      validator: (value) {
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: _matricula,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          labelText: "Matricula"),
                                      validator: (value) {
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: _email,
                                      decoration:
                                          InputDecoration(labelText: "email"),
                                      validator: (value) {
                                        return null;
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: 100,
                                        height: 50,
                                        child: Material(
                                          color: ThemeUSM.blackColor,
                                          textStyle:
                                              theme.textTheme.displayMedium,
                                          borderRadius: BorderRadius.all(
                                              Radius.elliptical(8, 6)),
                                          elevation: 10,
                                          child: InkWell(
                                            onTap: () async {
                                              await searchStudent(
                                                  context, controller);
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    "Buscar",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  (isSearched)
                      ? Padding(
                          padding: const EdgeInsets.all(8),
                          child: (allUsers.isNotEmpty)
                              ? SizedBox(
                                  height: 400,
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      User user = allUsers[index];
                                      return StudentCard(user: user);
                                    },
                                    itemCount: allUsers.length,
                                  ),
                                )
                              : Card(
                                  elevation: 10,
                                  color: theme.dividerColor,
                                  shadowColor: theme.colorScheme.onPrimaryFixed,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Nenhum usuario encontrado",
                                      style: theme.textTheme.displayMedium,
                                    ),
                                  ),
                                ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
