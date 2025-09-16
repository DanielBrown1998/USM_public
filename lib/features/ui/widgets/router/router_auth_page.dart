import 'package:app/core/theme/theme.dart';
import 'package:app/domain/models/user.dart';
import 'package:app/features/ui/widgets/gen/logo_laptop.dart';
import 'package:app/features/ui/widgets/gen/progress_indicator_usm.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RouterAuthPage extends StatefulWidget {
  final Future<User?> Function() function;
  final String routeNameSuccess;
  final String successMessage;
  final String messageLoad;
  final String errorMessage;
  final String? successlottie;
  final String? errorlottie;
  final String? defaultLottie;

  const RouterAuthPage({
    super.key,
    required this.function,
    required this.routeNameSuccess,
    required this.errorMessage,
    required this.successMessage,
    required this.messageLoad,
    this.successlottie,
    this.defaultLottie,
    this.errorlottie = "assets/loties/error.json",
  });

  @override
  State<RouterAuthPage> createState() => _RouterAuthPageState();
}

class _RouterAuthPageState extends State<RouterAuthPage> {
  late Future<User?> _authFuture;

  @override
  void initState() {
    super.initState();
    _authFuture = widget.function();
  }

  void _retry(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUSM.blackColor,
      body: FutureBuilder<User?>(
        future: _authFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasError &&
              snapshot.data != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await Future.delayed(const Duration(milliseconds: 1250));
              if (context.mounted) {
                Navigator.popAndPushNamed(context, widget.routeNameSuccess);
              }
            });
            return _buildContent(
              lottie: widget.successlottie,
              message: widget.successMessage,
            );
          }

          if (snapshot.hasError ||
              (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data == null)) {
            String errorMessage = snapshot.hasError
                ? snapshot.error.toString()
                : "Houve um erro inesperado!";
            if (errorMessage.contains("[firebase_auth/invalid-credential]")) {
              errorMessage = "Login ou senha invalidos";
            } else {
              errorMessage = "Erro ao tentar realizar login!";
            }

            return _buildContent(
              lottie: widget.errorlottie,
              message: errorMessage,
              showRetryButton: true,
            );
          }

          return _buildContent(
            lottie: widget.defaultLottie,
            message: widget.messageLoad,
            showProgress: true,
          );
        },
      ),
    );
  }

  Widget _buildContent({
    String? lottie,
    required String message,
    bool showRetryButton = false,
    bool showProgress = false,
  }) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: double.maxFinite,
        maxHeight: double.maxFinite,
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 5,
            child: (lottie == null)
                ? const LogoLaptop()
                : Lottie.asset(
                    key: Key("custom-lottie-route"),
                    lottie,
                    height: 250,
                    fit: BoxFit.fill,
                  ),
          ),
          if (showProgress)
            const Flexible(
              flex: 2,
              child: SizedBox(
                height: 50,
                width: 50,
                child: ProgressIndicatorUSM(),
              ),
            ),
          Flexible(
            flex: 2,
            child: Visibility(
              visible: showRetryButton,
              child: TextButton(
                  style: TextButton.styleFrom( 
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 4,
                      alignment: Alignment.center,
                      side: BorderSide(
                        color: ThemeUSM.backgroundColorWhite,
                        width: 2,
                      )),
                  onPressed: () => _retry(context),
                  child: const Text("Tentar novamente")),
            ),
          ),
          Flexible(
            flex: 1,
            child: Text(message,
                style: USMThemeData.themeData.textTheme.displayLarge,
                overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    );
  }
}
