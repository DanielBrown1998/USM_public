import 'package:app/core/routes/routes.dart';
import 'package:app/domain/models/user.dart';
import 'package:app/features/ui/widgets/gen/logo_laptop.dart';
import 'package:app/features/controllers/user_controllers.dart';
import 'package:app/core/theme/theme.dart';
import 'package:app/features/ui/widgets/router/router_auth_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticateScreen extends StatefulWidget {
  const AuthenticateScreen({super.key});

  @override
  State<AuthenticateScreen> createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  double _op = 0.0;
  bool visiblePassword = true;
  double bottomPadding = 48;
  MainAxisAlignment columnMainAxisAlignment = MainAxisAlignment.center;
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

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

  Future<User?> _authenticate(UserController controller,
      {required String email, required String password}) async {
    return await controller.login(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: ThemeUSM.blackColor,
      body: Center(
        child: Consumer<UserController>(
            builder: (context, UserController user, child) {
          return Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 2000),
                    opacity: _op,
                    curve: Curves.easeInCubic,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            key: Key("wellcome_text"),
                            "Bem vindo(a), ${user.user!.firstName} ${user.user!.lastName}",
                            style: theme.textTheme.displayLarge,
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            user.user!.userName,
                            style: theme.textTheme.displaySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  LogoLaptop(),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 2000),
                    opacity: _op,
                    curve: Curves.easeInCubic,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: theme.colorScheme.onPrimaryContainer),
                          borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 2.0),
                        child: Text(
                          "Realize seu Login",
                          style: theme.textTheme.displayMedium,
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        spacing: 40,
                        children: [
                          Material(
                            color: ThemeUSM.blackColor,
                            child: TextFormField(
                              style: theme.textTheme.displayMedium,
                              controller: emailController,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.center,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira seu email.';
                                }
                                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                  return 'Por favor, insira um email válido.';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "E-mail",
                                icon: Icon(Icons.login),
                                iconColor: ThemeUSM.whiteColor,
                                helperText: "Digite seu e-mail",
                                helperStyle: theme.textTheme.displaySmall,
                                constraints: BoxConstraints(
                                    minHeight: 60,
                                    maxHeight: 120,
                                    minWidth: double.maxFinite),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 300,
                                child: Material(
                                  color: ThemeUSM.blackColor,
                                  child: TextFormField(
                                    style: theme.textTheme.displayMedium,
                                    controller: passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    textAlign: TextAlign.center,
                                    maxLength: 20,
                                    maxLines: 1,
                                    obscureText: visiblePassword,
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      floatingLabelStyle:
                                          theme.textTheme.displaySmall,
                                      icon: Icon(Icons.password),
                                      iconColor:
                                          theme.colorScheme.onPrimaryContainer,
                                      helperText: "Digite sua senha!",
                                      helperStyle: theme.textTheme.displaySmall,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        visiblePassword = !visiblePassword;
                                      });
                                    },
                                    icon: Icon(
                                      (visiblePassword)
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color:
                                          theme.colorScheme.onPrimaryContainer,
                                    )),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, Routes.recoverPassword);
                                },
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    "Esqueci minha senha",
                                    style: theme.textTheme.displaySmall,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  if (!context.mounted) return;
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return RouterAuthPage(
                                      function: () async => _authenticate(user,
                                          email: emailController.text,
                                          password: passwordController.text),
                                      errorMessage: "Falha ao autenticar!",
                                      successMessage:
                                          "autenticação bem-sucedida!",
                                      routeNameSuccess: Routes.home,
                                      messageLoad: "Autenticando...",
                                      successlottie:
                                          'assets/loties/success.json',
                                      defaultLottie:
                                          'assets/loties/code_dark.json',
                                    );
                                  }));
                                },
                                child: Card(
                                  elevation: 10,
                                  shape: StadiumBorder(),
                                  margin: EdgeInsets.all(2),
                                  shadowColor:
                                      theme.colorScheme.onPrimaryContainer,
                                  color: theme.colorScheme.onPrimaryContainer,
                                  child: InkWell(
                                    splashColor:
                                        theme.colorScheme.onPrimaryFixed,
                                    child: Ink(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          "Entrar",
                                          style: theme.textTheme.displayLarge,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
