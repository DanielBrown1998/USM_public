import 'package:app/features/controllers/user_controllers.dart';
import 'package:app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({super.key});

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final GlobalKey<FormState> _recoverFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final userController = context.watch<UserController>();
    emailController.text = userController.user?.email ?? "";
    return Scaffold(
        backgroundColor: ThemeUSM.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Container(
            constraints: BoxConstraints(
              minHeight: size.height,
            ),
            child: Form(
              key: _recoverFormKey,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/loties/email_verification.json',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Por favor, insira seu email";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          final messenge = ScaffoldMessenger.of(context);
                          if (_recoverFormKey.currentState!.validate()) {
                            messenge.showSnackBar(SnackBar(
                                content: Row(
                              children: const [
                                CircularProgressIndicator(),
                                SizedBox(width: 16),
                                FittedBox(
                                    child: Text(
                                        "Enviando email de recuperação...")),
                              ],
                            )));
                            bool result = await userController
                                .forgetPassword(emailController.text);
                            if (result) {
                              messenge.showSnackBar(
                                SnackBar(
                                  content: FittedBox(
                                      child: Text(
                                          "Email de recuperação enviado para ${emailController.text}")),
                                ),
                              );
                              if (!context.mounted) return;
                              Navigator.pop(context);
                            } else {
                              messenge.showSnackBar(
                                const SnackBar(
                                  content: FittedBox(
                                      child: Text(
                                          "Erro ao enviar email de recuperação")),
                                ),
                              );
                            }
                          }
                        },
                        child: FittedBox(child: const Text("Recuperar Senha")),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
