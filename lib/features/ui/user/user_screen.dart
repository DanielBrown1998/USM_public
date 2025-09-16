import 'package:app/features/controllers/user_controllers.dart';
import 'package:app/core/services/auth_service.dart';
import 'package:app/core/theme/theme.dart';
import 'package:app/features/ui/widgets/cards/user_card.dart';
import 'package:app/features/ui/widgets/stack/stack_usm.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstName = TextEditingController();

  TextEditingController lastName = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController email = TextEditingController();

  bool updateUser = false;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StackUSM(
        child: SingleChildScrollView(
          child: Consumer<UserController>(builder: (context, user, widget) {
            auth.User? currentUser = AuthService().getUser;
            email.text = user.user!.email;
            phone.text = user.user!.phone;
            firstName.text = user.user!.firstName;
            lastName.text = user.user!.lastName;
            return !updateUser
                ? Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8, top: 48, bottom: 16),
                    child: Column(
                      spacing: 30,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Meus Dados",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge,
                        ),
                        UserCard(
                          user: user.user!,
                          currentUser: currentUser!,
                          photoURL: currentUser.photoURL,
                        ),
                        Lottie.asset("assets/loties/laptop.json"),
                        Text(
                          "Acoes a realizar:",
                          textAlign: TextAlign.start,
                          style: theme.textTheme.displayLarge!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        (!currentUser.emailVerified)
                            ? Material(
                                color: ThemeUSM.purpleUSMColor,
                                shape: Border.all(
                                  width: 2,
                                  style: BorderStyle.solid,
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                                elevation: 10,
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  splashColor: theme.splashColor,
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "verificar email",
                                        style: theme.textTheme.displayMedium,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                        (currentUser.phoneNumber == null)
                            ? Material(
                                color: ThemeUSM.purpleUSMColor,
                                shape: Border.all(
                                  width: 2,
                                  style: BorderStyle.solid,
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                                elevation: 10,
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  splashColor: theme.splashColor,
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "validar celular",
                                        style: theme.textTheme.displayMedium,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8, top: 48, bottom: 16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Atualizar Dados",
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            style: theme.textTheme.bodyMedium,
                            controller: firstName,
                            decoration: const InputDecoration(
                              labelText: 'nome: ',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira seu nome.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            style: theme.textTheme.bodyMedium,
                            controller: lastName,
                            decoration: const InputDecoration(
                              labelText: 'sobre-nome: ',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira seu sobre-nome.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            style: theme.textTheme.bodyMedium,
                            initialValue: user.user!.userName,
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'matricula: ',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            style: theme.textTheme.bodyMedium,
                            controller: email,
                            decoration: const InputDecoration(
                              labelText: 'e-mail: ',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira seu email.';
                              }
                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return 'Por favor, insira um email válido.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            style: theme.textTheme.bodyMedium,
                            controller: phone,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'phone: ',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira seu telefone.';
                              }
                              if (value.length != 11) {
                                return "11 digitos apenas";
                              }
                              if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                return 'Por favor, insira um telefone válido (apenas números).';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            style: theme.textTheme.bodyMedium,
                            initialValue: user.user!.campus,
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'campus',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          }),
        ),
      ),
    );
  }
}
